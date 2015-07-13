class AddShitToProducts < ActiveRecord::Migration
  def change
    remove_column :products, :image_file_name
    add_attachment :products, :image
    add_attachment :products, :pdf
  end
end
