class CreateCartsTable < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :shopper_id
      t.integer :tax_rate
    end
  end
end
