module Login
  extend ActiveSupport::Concern

  private

    def login(user)
      session[:user_id] = user.id
      # if the user already had a cart from previous shopping,
      # those items should be in the cart
      # if the user had been shopping prior to logging in,
      # those items should end up in cart too
      old_cart = user.cart
      if session[:cart_id]
        cart = Cart.find(session[:cart_id])
        user.cart = cart
        user.cart.merge(old_cart) unless old_cart == cart
      end
    end
end