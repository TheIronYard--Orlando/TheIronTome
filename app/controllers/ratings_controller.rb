class RatingsController < ApplicationController
  before_action :find_item

  def create
    @rating = @item.create_rating(rating_params)
  end

  def update
    @item.rating.update_attributes(rating_params)
    render :create
  end

  private

    def find_item
      @item = current_user.line_items.includes(:rating, :order).find(params[:line_item_id])
    end

    def rating_params
      params.require(:rating).permit(:stars)
    end
end