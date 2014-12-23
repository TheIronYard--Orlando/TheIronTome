class StoreController < ApplicationController
  def index
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end

    @visit_count = session[:counter]
    @products = Product.order(:title)
  end
end
