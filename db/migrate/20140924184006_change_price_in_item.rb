class ChangePriceInItem < ActiveRecord::Migration
  def change
    change_column :items, :price, :decimal, precision: 7, scale: 2
  end
end
