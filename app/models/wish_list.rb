class WishList < ActiveRecord::Base
  belongs_to :user
  has_many :products	
end

 def add_product_to_wish_list(product_id)
   wish_list = user.wish_list.create(product_id: product_id)
 end



  