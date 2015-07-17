class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :line_item, index: true, foreign_key: true
      t.integer :stars

      t.timestamps null: false
    end
  end
end
