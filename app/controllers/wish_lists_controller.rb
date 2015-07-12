class WishListsController < ApplicationController
  
  # def index
  #   @wish_lists = WishLists.all
  #   @wish_list = WishList.new
  # end

  def show
    @wish_list = WishList.find(params[:id])
  end

  def edit
  	@wish_lists = WishList.find(params[:id])
  end

  def update
  	@wish_lists = WishList.find(params[:id])
  	#render "store/index"
  end

  def new
  	@wish_lists = WishList.new

      flash.now[:notice] = "This item has been added to your wish list"
      
  end

  def create
    @wish_lists = WishList.new(wish_list_params)

    flash.now[:notice] = " has been added to your wish list"
    
  end 

  def destroy
    @wish_list = WishList.find(params[:id])
    @wish_list.destroy

    redirect_to root_url
  end 

  private

  def wish_list_params
    #params.permit(:user_id, :product_id)
    params.permit(:user_id, :product_id)
  end
end
