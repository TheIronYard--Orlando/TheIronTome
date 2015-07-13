class AddAndRemoveFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :address
    remove_column :orders, :email
    remove_column :orders, :name
    add_column :orders, :user_id, :integer
    add_column :orders, :sales_tax, :float
    ### address(itemized), name, and email were moved to user model
  end
end
