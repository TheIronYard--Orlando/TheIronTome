class AddColumnsToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :shipping_cost, :float
  	add_column :orders, :coupon_discount, :float
  	add_column :orders, :order_total, :float
  end
end

