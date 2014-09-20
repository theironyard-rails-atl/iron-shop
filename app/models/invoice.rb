class Invoice < ActiveRecord::Base
  belongs_to :user

  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates_presence_of :user, :amount
end
