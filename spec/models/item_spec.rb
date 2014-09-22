require 'rails_helper'

describe Item do
  %i(price seller title).each do |field|
    it "requires a #{field}" do
      # item = build :item, :price => nil
      item = build :item, field => nil
 o     expect( item.valid? ).to be false
    end
  end

  it 'requires price to be positive' do
    item = build :item, price: -1.00
    # expect( item ).not_to be_valid ~> valid?
    expect( item.valid? ).to be false
  end
end
