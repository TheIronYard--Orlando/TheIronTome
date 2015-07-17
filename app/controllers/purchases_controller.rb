class PurchasesController < ApplicationController

  def index
    @purchases = current_user.orders.includes(line_items: :product)
  end

  def show
    @purchase = current_user.orders.includes(:line_items => [ :product, :rating ]).find(params[:id])
    @purchase.line_items.each{|item| item.build_rating(stars: 0) unless item.rating }
  end
end
