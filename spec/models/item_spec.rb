# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  price       :float
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  invoice_id  :integer
#

require 'rails_helper'

describe Item do
  %i(price seller title).each do |field|
    it "requires a #{field}" do
      # item = build :item, :price => nil
      item = build :item, field => nil
      expect( item.valid? ).to be false
    end
  end

  it 'requires price to be positive' do
    item = build :item, price: -1.00
    # expect( item ).not_to be_valid ~> valid?
    expect( item.valid? ).to be false
  end

  it 'searches an item by title' do
    item = create :item
    expect( Item.search_by_item(item.title)).to include item
  end

  it 'searches an item by description' do
    item = create :item
    expect( Item.search_by_item(item.description)).to include item
  end

end
