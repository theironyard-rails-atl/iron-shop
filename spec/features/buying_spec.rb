require 'rails_helper'

feature 'Buying' do
  
  it 'shows the user a list of all items by default' do
    item = create :item
    visit root_path
    expect( page ).to have_content item.title
  end

  it 'lets buyers search for items' do
    item_1 = create :item
    item_2 = create :item
    visit root_path
    #get search controller method via ajax for item_1.title
    expect( page ).to have_content item_1.title
    expect( page ).to_not have_content item_2.title
  end

  it 'lets buyers view their cart'
  it 'lets buyers checkout'
end
