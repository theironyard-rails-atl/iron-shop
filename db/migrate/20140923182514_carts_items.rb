class CartsItems < ActiveRecord::Migration
  def change
    create_table :carts_items do |t|
      t.integer :cart_id
      t.integer :item_id
    end
  end
end
