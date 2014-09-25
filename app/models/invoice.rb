# == Schema Information
#
# Table name: invoices
#
#  id         :integer          not null, primary key
#  amount     :float
#  shopper_id :integer
#  created_at :datetime
#  updated_at :datetime
#  paid       :boolean          default(FALSE)
#

class Invoice < ActiveRecord::Base
  validates_presence_of :shopper_id, :amount
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :shopper, class_name: "User"

  has_many :invoice_items
  has_many :items, through: :invoice_items

  def amount_in_cents
    (self.amount * 100).round()
  end

end
