class AddDimensionsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :length, :float, default: 0
    add_column :products, :width, :float, default: 0
    add_column :products, :height, :float, default: 0
    add_column :products, :weight , :float, default: 0
  end
end
