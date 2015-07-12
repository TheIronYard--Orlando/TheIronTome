class CreateWishLists < ActiveRecord::Migration
  def change
    create_table :wish_lists do |t|
      t.integer :user_id
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
