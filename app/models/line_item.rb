class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart
  has_one :rating
  delegate :title, :description, to: :product

  def total_price
    product.price * quantity
  end
end
