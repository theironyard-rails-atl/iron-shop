class ChangeTaxRateInInvoices < ActiveRecord::Migration
  def change
    change_column :invoices, :tax_rate, :decimal, precision: 5, scale: 2, default: 0.04
  end
end
