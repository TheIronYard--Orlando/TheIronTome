class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
    	t.integer :product_id
    	t.integer :user_id
    	t.integer :stars
    	
      t.timestamps null: false
    end
  end
end
