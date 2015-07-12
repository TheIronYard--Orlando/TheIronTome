class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart
  has_many :ratings, through: :users

  def total_price
    product.price * quantity
  end
end
