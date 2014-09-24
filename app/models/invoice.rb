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
    (amount * 100).to_i
  end
end


