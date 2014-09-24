# == Schema Information
#
# Table name: invoice_items
#
#  id         :integer          not null, primary key
#  invoice_id :integer
#  item_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :item
end
