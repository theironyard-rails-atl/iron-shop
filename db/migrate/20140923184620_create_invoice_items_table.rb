class CreateInvoiceItemsTable < ActiveRecord::Migration
  def change
    create_table :invoiceitems do |t|
      t.references :invoice, index: true
      t.references :item, index: true
    end
  end
end
