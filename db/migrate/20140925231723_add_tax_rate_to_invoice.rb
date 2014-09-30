class AddTaxRateToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :tax_rate, :decimal, precision: 5, scale: 2
    add_column :invoices, :cart_active, :boolean, default: true
  end
end
