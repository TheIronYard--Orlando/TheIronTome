class ChangeUserDataFirst < ActiveRecord::Migration
  def change
    add_column :users, :address_1, :string
    add_column :users, :address_2, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zipcode, :integer
    add_column :users, :email, :string
    ### email was moved from order
      ### email is now log in username
      ### name no longer is username and is part of address
  end
end
