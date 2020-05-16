class CartController < ApplicationController
  before_action :authenticate_user!

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
    product_id = params[:product_id].to_i
    redirect_to(home_index_path, notice: 'product not found') unless product_id

    # get the shopping cart of the user
    cart = Order.where(user_id: current_user.id, is_checked: false).first
    unless cart # there is no cart, create one
      cart = Order.new user_id: current_user.id, is_checked: false
      cart.save
    end

    # check if the product already in the cart,
    # get it ..
    cart_item = cart.OrderProducts.find_by product_id: product_id
    # stock_quantity = cart_item.product.stock_quantity if cart_item != nil
    stock_quantity = Product.find(product_id).stock_quantity
    notice = ''

    if cart_item # item already in the cart, only update quantity
      if stock_quantity.zero?
        cart_item.update(quantity: 0)
        notice = 'not enough quantity in available stock'
      elsif stock_quantity <= cart_item.quantity
        cart_item.update(quantity: stock_quantity)
        notice = 'You got all the available stock'
      else
        cart_item.update(quantity: cart_item.quantity + 1)
        notice = 'successfully added item to cart'
      end
    elsif stock_quantity.positive? # stock_quantity > 0 # not in the cart, add it
      cart.OrderProducts.create product_id: product_id, quantity: 1
      notice = 'successfully added item to cart'
    else
      notice = 'Not enough quantity stock'
    end
    redirect_to cart_path, notice: notice # TODO : localize it
  end

  def destroy
    # get the shopping cart of the user
    @cart = Order.where(user_id: current_user.id, is_checked: false).first
    @cart.OrderProducts.find_by(order_id: @cart.id, product_id: params[:product_id]).destroy
    render 'index'
  end

end
