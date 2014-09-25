class SetDefaultAmountInInvoice < ActiveRecord::Migration
  def change
    change_column :invoices, :amount, :decimal, precision: 7, scale: 2, default: 0.00
  end
end
