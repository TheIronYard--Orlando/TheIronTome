class AddOrderToPayType < ActiveRecord::Migration
  def up
    add_reference :orders, :pay_type, index: true

    say_with_time "Fill pay_type_id..." do
      Order.all.each do |order|
        order.update_column :pay_type_id, PayType.find_by_name(order.read_attribute(:pay_type)).id
      end
    end
  end

  def down
    remove_reference :orders, :pay_type, index: true
  end
end
