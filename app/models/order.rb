class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :pay_type
  belongs_to :cart
  belongs_to :user
  delegate :email, :name, :address, to: :user
  # means you can use order.email 
  # instead of order.user.email


  validates :pay_type_id, presence: true

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

    
end
