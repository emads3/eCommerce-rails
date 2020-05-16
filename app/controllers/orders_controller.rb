class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to 'home#index' unless user_signed_in?
    @orders = OrderWithPrice.where(is_checked: true, user_id: current_user.id).order(id: :desc)

    @orders.each_with_index do |order, i|
      @orders[i].state = accessor_order_state order
      @orders[i].total_price = accessor_order_total_price(order)
    end
    @orders
  end

  def new
    @cart = Order.where(is_checked: false, user_id: current_user.id).first
    # there is order
    redirect_to cart, notice: 'There is no products in your cart to checkout' unless @cart

    # @order = Order.new(is_checked: false, user_id: current_user.id)
    if @cart.OrderProducts.count.positive? # items in cart > 0
      render :new
    else
      redirect_to @cart, notice: 'you don\'t have any items in your cart to checkout'
    end
  end


  def show
    Order.where(is_checked: true, user_id: current_user.id, id: params[:id])
    redirect_to orders_path
  end

  def update
    Order.where(id: params[:id], is_checked: false, user_id: current_user.id).first.update(place_order_params)
    redirect_to orders_path, notice: 'successfully made a an order, check the order status periodically.'
  end


  private

  def place_order_params
    #  is_checked: true, params.require(:cart).require[:billing_address, :shipping_address]
    params.require(:order).permit(:billing_address, :shipping_address).merge(is_checked: true)
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
