class CreatePayTypes < ActiveRecord::Migration
  def up
    create_table :pay_types do |t|
      t.string :name
    end


    say_with_time "Seeding pay_types..." do
      ["Check", "Credit card", "Purchase order"].each do |pay_type|
        PayType.create(name: pay_type)
      end
    end
  end

  def down
    drop_table :pay_types
  end
end
