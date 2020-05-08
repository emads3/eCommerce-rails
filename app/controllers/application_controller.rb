class ApplicationController < ActionController::Base
    before_action:render_categories
    def render_categories
        @categories=Category.all
    end
    
end
