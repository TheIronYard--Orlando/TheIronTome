class AddCartIdToOrders < ActiveRecord::Migration
  def change
    rename_column :orders, :user_id, :cart_id
  end
end
