class ApplicationController < ActionController::Base

    before_action :render_categories,:render_products,:render_brands,:render_orders,:render_stores, :cart_items_count
    def render_categories
        @allCategories=Category.all
    end

    def render_products
        @products = Product.order(:title).page(params[:page]).per(10)
    end

    def render_brands
        @allbrands=Brand.all
    end

    def render_orders
        @orders=Order.all
    end

    def render_stores
        @allstores=Store.all
    end

    def cart_items_count
        if user_signed_in?
            cart = Order.where(user_id: current_user.id, is_checked: false).first
            @cart_items_count = cart ? cart.OrderProducts.count : 0
        end
    end

end
