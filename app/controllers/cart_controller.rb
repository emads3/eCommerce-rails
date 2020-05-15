class CartController < ApplicationController

  # todo : handle if the user added item to the cart and there is not enough stock quantity
  # no index methdd, only show (no view for 'carts', but view for single 'cart')
  def show
    # get the shopping cart of the user
    @cart = Order.where(user_id: current_user.id, is_checked: false).first

    unless @cart #tested and works
      @cart = Order.new user_id: current_user.id, is_checked: false
      @cart.save
    end
    render 'index'
  end

  def create
    @product_id = params[:product_id].to_i
    redirect_to(home_index_path, notice: 'product not found') unless @product_id

    # get the shopping cart of the user
    @cart = Order.where(user_id: current_user.id, is_checked: false).first
    unless @cart # there is no cart, create one
      @cart = Order.new user_id: current_user.id, is_checked: false
      @cart.save
    end

    # check if the product already in the cart,
    # get it ..
    @prod = @cart.OrderProducts.find_by product_id: @product_id
    if !@prod
      @cart.OrderProducts.create product_id: @product_id, quantity: 1
    else
      @prod.update(quantity: @prod.quantity + 1)
    end
    redirect_to cart_path, notice: 'successfully added item to cart' # TODO : localize it
  end

  def destroy
    # get the shopping cart of the user
    @cart = Order.where(user_id: current_user.id, is_checked: false).first
    @cart.OrderProducts.find_by(order_id: @cart.id, product_id: params[:product_id]).destroy
    render 'index'
  end

end
