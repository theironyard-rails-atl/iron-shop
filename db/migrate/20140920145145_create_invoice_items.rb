class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.references :invoice, index: true
      t.references :item, index: true

      t.timestamps
    end
  end
end
