class Invoice < ActiveRecord::Base
  #TODO: Ask James if this should be a has_one or belongs_to
  belongs_to :user
  has_many :invoiceitems
  has_many :items, through: :invoiceitems

  validates_presence_of :user, :amount

end
