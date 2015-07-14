class AddColumnToOrder < ActiveRecord::Migration
  def change
  		add_column :orders, :order_sub_total, :float
  end
end
