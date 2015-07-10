class AddShitToProducts < ActiveRecord::Migration
  def change
    remove_column :products, :image_url
    add_attachment :products, :image
    add_attachment :products, :pdf
  end
end
