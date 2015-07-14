class StoreController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart

  def index
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      @products = Product.order(:title).page(params[:page]).per(10)
    end

    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end

    @visit_count = session[:counter]

    @products = Product.order(:title).page(params[:page]).per(10)
    @wish_lists = WishList.new(wish_list_params)

  end
   
   # @wish_list = WishList.new

 def wish_list_params
     params.permit(:user_id, :product_id)
   end
end
