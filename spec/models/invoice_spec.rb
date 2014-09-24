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

require 'rails_helper'

describe Invoice do
  %i(shopper amount).each do |field|
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
end
