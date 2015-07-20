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
    if I18n.locale && I18n.locale != 'en'
      @products.each{|product| product.translate_title_and_description(I18n.locale) }
    end
  end
end
