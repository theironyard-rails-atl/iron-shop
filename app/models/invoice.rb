# == Schema Information
#
# Table name: invoices
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  amount     :decimal(7, 2)
#  created_at :datetime
#  updated_at :datetime
#  paid       :boolean
#

class Invoice < ActiveRecord::Base
  belongs_to :user
  has_many :items
  validates_presence_of :user, :amount

  def amount_in_cents
    total
    (amount * 100).to_s.to_i
  end

  def add item_id
    item = Item.find(item_id)
    items << item
  end

  def remove item 
    items.delete item
  end

  def clear
    items.delete_all
  end

  def subtotal
    items.reduce(0) do |total,item|
      total +=  item.price
      total 
    end
  end

  def total
   self.amount = (subtotal * (1.0 + tax_rate)).round 2 
   self.save
   self.amount
  end
  
  def checkout
    cart_active = false
  end

end


