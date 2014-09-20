class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :user, index: true
      t.decimal :amount, precision: 7, scale: 2
      t.boolean :paid

      t.timestamps
    end
  end
end
