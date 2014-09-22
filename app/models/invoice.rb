class Invoice < ActiveRecord::Base
  belongs_to :user
  has_many :items
  validates_presence_of :user, :amount
  
  def pay_invoice payment
    amount -= payment
  end

  def paid?
   amount == 0 
  end
end


