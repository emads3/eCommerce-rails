class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  def create
    @product_id = params[:product_id].to_i
    return unless @product_id

    # get the shopping cart of the user
    @cart = Order.where(user_id: current_user.id, is_checked: false).first # no need for .take ?
    unless @cart # there is not cart, create one
      @cart = Order.new user_id: current_user.id, is_checked: false
      @cart.save
    end
    # puts YAML::dump(@cart)
    @prod = @cart.OrderProducts.find_by product_id: @product_id
    if !@prod
      @cart.OrderProducts.create product_id: @product_id, quantity: 1
    else
      @prod.update(quantity: @prod.quantity + 1)
    end
    redirect_to orders_path
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.fetch(:order, {})
  end
end
