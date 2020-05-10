class ShoppingCartsController < ApplicationController
    def index
        @shopping_cart=ShoppingCart.new(:user_id =>current_user.id)
        @shopping_cart.save
        
        @shopping_cart.product_shoppings.create(:product_id => params[:product])
       
        @shopping_carts=ShoppingCart.all
       
      
    end  
 
    

    def show
        @shopping_cart=ShoppingCart.find(params[:id]) 
    end 
    def create
        
    end    
    private
    def cart_params
      params.require(:shopping_cart).permit()
    end
      
   
end
