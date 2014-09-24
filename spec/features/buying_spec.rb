require 'rails_helper'

feature 'Buying', :js, :focus do
  before :each do
    @user = create :user
    login @user

    create :item
  end

  it 'lets buyers search for items'
  it 'lets buyers add items to their cart' do
    visit cart_path
    expect(page).not_to have_css('.item')
    visit items_path
    click_link("Add to Cart", match: :first)
    item = Item.first
    expect(page).to have_css('.item')
  end
  it 'lets buyers view their cart' do
    visit items_path
    click_link("Add to Cart", match: :first)
    item = Item.first
    expect(page).to have_content(item.title)
    expect(page).to have_content(item.description)
    expect(page).to have_content(item.price)
  end
  it 'lets buyers remove items from their cart' do
    visit items_path
    click_link("Add to Cart", match: :first)
    expect(page).to have_css('.item')
    find('.remove-button').click
    expect(page).not_to have_css('.item')
  end
  it 'lets buyers checkout'
end
