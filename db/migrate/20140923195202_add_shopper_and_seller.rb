class AddShopperAndSeller < ActiveRecord::Migration
  def change
    add_column :users, :shopper, :boolean, default: true
    add_column :users, :seller,  :boolean, default: false
  end
end
