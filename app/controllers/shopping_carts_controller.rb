class ShoppingCartsController < ApplicationController
    before_action :authenticate_user!,only: [:show,:index,:create, :destroy]
   

    def index
        @shopping_cart=ShoppingCart.find_by user_id: current_user.id
        if(!@shopping_cart)
            @shopping_cart=ShoppingCart.new(:user_id =>current_user.id)
            @shopping_cart.save
        end
        if params[:product] 
            @product=Product.find(params[:product])
            @shop=  @shopping_cart.product_shoppings.find_by product_id: params[:product]
            if @product.stock_quantity > 0 
                if ! @shop

                    @shop=@shopping_cart.product_shoppings.create(:product_id => params[:product] , :quantity => 1)      
                else
                    @shop.quantity = @shop.quantity+1
                end                
            end
        end
        # @shopping_carts = ShoppingCart.order(:name).page(params[:page]).per(5)
        @total= 0
        @shopping_carts =ShoppingCart.where("user_id == ?", current_user.id).order(:name).page(params[:page]).per(5)
    end  
 
    def destroy
        @shopping_cart=ShoppingCart.find_by user_id: current_user.id
        @shopping_cart = @shopping_cart.product_shoppings.find_by product_id: params[:product]
        @product=Product.find(params[:product])
        if @product.stock_quantity
            if @product.stock_quantity > 0
                 @shopping_cart.destroy
            end
        
        end
        redirect_to action: 'show'
    end   
    def show
        @total= 0
        @shopping_cart=ShoppingCart.find_by user_id: current_user.id 
    end    
      
   
end
