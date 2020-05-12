class ApplicationController < ActionController::Base
    
    before_action :render_categories,:render_products,:render_brands,:render_orders,:render_stores
    def render_categories
        @allCategories=Category.all
    end
    
    def render_products
        @products = Product.order(:name).page(params[:page]).per(10)
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
    
end
