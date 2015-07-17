class RatingsController < ApplicationController


	def  create
		@rating = current_user.ratings.build(product_id: params[:product_id])
		if @rating.save
			flash.now[:notice] = "Thank you for rating this product"
		end	
	end

	# def destroy
	# 	@rating = Rating.find(params[:id])
	#   @rating.destroy
	#   redirect_to order_url		
	# end		



end
