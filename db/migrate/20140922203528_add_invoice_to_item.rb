class AddInvoiceToItem < ActiveRecord::Migration
  def change
    add_column :items, :invoice_id, :integer
  end
end
