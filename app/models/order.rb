class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :pay_type
  belongs_to :cart

  # validate :line_items_exist

  validates :pay_type_id, presence: true


  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  # def line_items_exist
  #     redirect_to store_url if line_items.empty?
  #     notice: "Add product to cart" 
  #   end  
  # end
    
end
