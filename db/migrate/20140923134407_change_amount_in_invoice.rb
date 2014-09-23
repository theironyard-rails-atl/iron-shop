class ChangeAmountInInvoice < ActiveRecord::Migration
  def change
    change_column :invoices, :amount, :decimal, precision: 7, scale: 2
  end
end
