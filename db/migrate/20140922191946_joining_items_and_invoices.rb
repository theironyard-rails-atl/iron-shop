class JoiningItemsAndInvoices < ActiveRecord::Migration
  def change
    create_table :invoices_items, id: false do |t|
      t.belongs_to :invoice
      t.belongs_to :item
    end
  end
end
