class AddPriceToLineItems < ActiveRecord::Migration
  def up
    add_column :line_items, :price, :decimal, precision: 8, scale: 2

    say_with_time "Updating line item prices..." do
      LineItem.all.each do |line_item|
        line_item.update(price: line_item.product.price)
      end
    end
  end

  def down
    remove_column :line_items, :price
  end
end
