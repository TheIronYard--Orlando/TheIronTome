class Cart < ActiveRecord::Base
  has_many :line_items#, dependent: :destroy
  belongs_to :user
  has_many :orders
  after_destroy :delete_orphaned_line_items

  def add_product(product_id, product_price, qty = 1)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += qty
    else
      current_item = line_items.build(product_id: product_id, 
        price: product_price, quantity: qty)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def merge(other_cart)
    return if other_cart.nil?
    other_cart.line_items.each do |line_item|
      add_product(line_item.product_id, line_item.price,
                  line_item.quantity)
    end
    save
  end

  private

    def delete_orphaned_line_items
      line_items.each{|line_item| line_item.destroy if line_item.order_id.nil? }
    end
end
