class Invoice < ActiveRecord::Base
  belongs_to :user

  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates_presence_of :user, :amount

  def amount_in_cents
    (self.amount * 100).to_i
  end
end
