class WishListsController < ApplicationController
  
  def index
    @wish_lists = WishList.all
  end

  def show
    @wish_list = WishList.where("wish_lists.user_id = ?", user.id)
  end
  # show page should only show the products(title,description and price) via product_id,
  # associated with a particular user_id. user_id should be the current user.
  #   @wish_list = current_user.
  def edit
  	@wish_list = WishList.find(params[:id])
  end

  def update
  	@wish_list = WishList.find(params[:id])
  	#render "store/index"
  end

  def new
  	@user = User.find(params[:user_id])
  	@wish_list = WishList.new

    flash.now[:notice] = "This item has been added to your wish list"
      
  end

  def create
    @wish_list = WishList.new(wish_list_params)
      
      if @wish_list.save
      flash.now[:notice] = "This item has been added to the list"
      #redirect_to root_url
    else
      flash.now[:notice] = "Sorry, this item cannot added at this time"
    end
  end
    # respond_to do |format|
    #   if @wish_list.save
    #     format.html { redirect_to @wish_list, notice: 'This item was successfully added.' }
    #     format.json { render :show, status: :created, location: @wish_list }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @wish_list.errors, status: :unprocessable_entity }
    #   end
    # end
  #end
  
  def destroy
    @wish_list = WishList.find(params[:id])
    @wish_list.destroy

    redirect_to root_url
  end 

  private

  def wish_list_params
    #params.permit(:user_id, :product_id)
    params.require(:wishlist).permit(:user_id, :product_id)
  end
end
