module CurrentCart
  extend ActiveSupport::Concern
=begin
  a couple of work flow possibilities:

as soon as a visitor visits the front page, 
a cart is created.

if a user is logged in,
when a cart is created,
the user should be associated with that cart.

if a user is not logged in,
the existing cart
should be associated with the user when the user logs in.

when is the cart created?
=end
  
  private
    def set_cart
      @cart = Cart.find_by(id: session[:cart_id], user_id: current_user.id)
      if @cart.nil?
        if current_user.persisted?
          @cart = current_user.create_cart
        else
          @cart = Cart.create
        end
      end
      session[:cart_id] = @cart.id
    end

end
