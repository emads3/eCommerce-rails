class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    redirect_to 'home#index' unless user_signed_in?
    @orders = OrderWithPrice.where(is_checked: true, user_id: current_user.id)

    @orders.each_with_index do |order, i|
      @orders[i].state = accessor_order_state order
      @orders[i].total_price = accessor_order_total_price(order)
    end
    @orders
  end

  def new
    @order = Order.new(params[:order_id])
  end

  def show
    Order.where(is_checked: true, user_id: current_user.id, id: params[:id])
    redirect_to orders_path
  end

  def update
    Order.find(params[:id]).update(is_checked: true)
    redirect_to orders_path, notice: 'successfully made a an order, check the order status periodically.'
  end


  private

  # fixme: remove this two methods
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.fetch(:order, {})
  end

  def accessor_order_state(order)
    # three states of orderProduct : cancelled, confirmed, *pending (default)
    # zero for pending, 1 for confirmed and -1 for cancelled

    # puts '======================================================'
    # puts "order ID: #{order.id}"
    # puts '======================================================'

    # initially assume all order products state = confirmed
    order_state = 1
    order.OrderProducts.each do |order_product|
      # if there is any single nil confirmation state, eval order state to pending
      is_pending = order_product.product_seller_confirmation_state.to_i == 0 ||
          order_product.product_seller_confirmation_state.to_i == -1
      # puts '======================================================'
      # puts order.id
      # puts is_pending
      # puts '======================================================'
      if is_pending
        order_state = 0
        break
      end
    end
    order_state
  end

  def accessor_order_total_price(order)
    total_price = 0
    order.OrderProducts.each do |order_product|
      total_price += order_product.quantity * Product.find(order_product.product_id).price
    end
    total_price
  end

  # I just added this class to bind a new property to it,
  # since I can't make @order.total_price (err: no method called total_price)
  # So I created this class just to add a property to it and nothing more...
  class OrderWithPrice < Order
    attr_accessor :total_price
    attr_accessor :state

    def initialize(attributes = nil)
      super
      @total_price = 0
      @state = 0
    end
  end

end
