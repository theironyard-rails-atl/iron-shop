class Invoice < ActiveRecord::Base
  validates_presence_of :shopper_id, :amount
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :shopper, class_name: "User"
  has_many :invoice_items
  has_many :items, through: :invoice_items

end
