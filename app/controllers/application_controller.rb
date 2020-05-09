class ApplicationController < ActionController::Base
    before_action :render_categories,:render_products
    def render_categories
        @allCategories=Category.all
    end
    
    def render_products
        @products = Product.all
    end
    
end
