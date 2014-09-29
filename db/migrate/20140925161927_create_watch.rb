class CreateWatch < ActiveRecord::Migration
  def change
    create_table :watches do |t|
      t.decimal :price, precision: 7, scale: 2
      t.belongs_to :item
      t.belongs_to :user
    end
  end
end
