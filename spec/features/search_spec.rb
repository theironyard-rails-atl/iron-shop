require 'rails_helper'

describe Item do
   it 'allows to search for items' do
     shopper = create(:user, :shopper)
     login shopper
     visit items_path
     item = create :item
     fill_in "query", with: item.title

     click_button "Search"
     
     expect(page).to have_content item.title
     expect(page).to have_content item.description
   end   
end
