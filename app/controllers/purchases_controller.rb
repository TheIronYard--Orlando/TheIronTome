class PurchasesController < ApplicationController

  def index
    @purchases = current_user.orders.includes(line_items: :product)
  end
end
