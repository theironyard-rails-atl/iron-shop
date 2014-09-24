require 'rails_helper'

feature 'Buying', :js, :focus do
  before :each do
    @user = create :user
    login @user

    4.times do
      create :item
    end
  end

  it 'lets buyers search for items'
  it 'lets buyers add items to their cart' do
    visit items_path
    click_link("Add to Cart", match: :first)
  end
  it 'lets buyers view their cart'
  it 'lets buyers remove items from their cart'
  it 'lets buyers checkout'
end
