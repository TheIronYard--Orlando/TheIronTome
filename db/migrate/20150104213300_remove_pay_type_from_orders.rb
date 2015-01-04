class RemovePayTypeFromOrders < ActiveRecord::Migration
  def up
    remove_column :orders, :pay_type
  end

  def down
    add_column :orders, :pay_type, :string

    say_with_time "Filling pay_type..." do
      Order.all.each do |order|
        order.update_column :pay_type, PayType.find(order.read_attribute(:pay_type_id)).read_attribute(:name)
      end
    end
  end
end
