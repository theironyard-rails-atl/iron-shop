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

require 'rails_helper'

describe Invoice do
  before :each do
    @shopper = create :user, :shopper
    @invoice = create :invoice, user: @shopper
  end

  %i(user amount).each do |field|
    it "requires a #{field}" do
      invoice = build :invoice, field => nil
      expect( invoice.valid? ).to eq false
    end
  end

  it 'contains items' do
    invoice = create :invoice
    3.times { invoice.items << create(:item) }
    expect( invoice.items.count ).to eq 3
  end

  it 'has an active cart on creation' do 
    expect(@invoice.cart_active).to be true
  end 

end
