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
