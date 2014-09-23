class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.float :amount
      t.integer :shopper_id

      t.timestamps
    end
  end
end
