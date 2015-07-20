namespace :products do
  desc "TODO"
  task add_inventory: :environment do
    Product.all.each do |product|
      product.update_attribute :inventory, rand(100) + 1
    end
  end

  desc "TODO"
  task add_dimensions: :environment do
    Product.all.each do |product|
      product.update_attributes(height: rand(5) + 1, width: rand(9) + 1, 
                                length: rand(13) + 1, weight: rand(10) + 1)
    end
  end
end
