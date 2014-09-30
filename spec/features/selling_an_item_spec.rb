require 'rails_helper'

feature 'Selling' do
  it 'allows sellers to list items for sale' do
    seller = create(:user, :seller)  #role: seller?
    login seller
    visit new_item_path

    fill_in "Title", with: "Bananas"
    fill_in "Description", with: "Delicious"
    fill_in "Price", with: "100"
    click_button "Create Item"

    expect(page).to have_content "Successful"
    expect(page).to have_content "Bananas"

    #move to controller/model spec?
    expect(Item.count).to eq 1
  end

  it 'requires users to be sellers before listing an item' do
    user = create(:user, :shopper)
    login user
    visit new_item_path

    expect(page).not_to have_content "Create Item"
  end

  # Add further CanCan authorization specs
  it 'allows sellers to edit an item' do
    seller = create(:user, :seller)
    item = create(:item, seller: seller)
    login seller
    visit edit_item_path item

    fill_in "Title", with: "help"
    fill_in "Description", with: "No"
    fill_in "Price", with: "3"

    click_button "Update Item"

    expect(page).to have_content "Successful" 
  end

  it 'errors on incorrect updateitems' do
    seller = create(:user, :seller)
    item = create(:item, seller: seller)
    login seller
    visit edit_item_path item

    fill_in "Price", with: "no worky"

    click_button "Update Item"

    expect(page).to have_content "Item could not be updated"

  end
  it 'allows sellers to delete posted items they own'
  it 'does not allow sellers to delete other sellers items'
end
