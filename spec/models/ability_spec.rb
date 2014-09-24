require 'rails_helper'

describe Ability do
  it "allows sellers to post items" do
    seller = create :user, :seller
    item = create :item, seller: seller
    abilities = Ability.new seller 
    expect( abilities.can? :manage, Item ).to be true
  end

  it "sellers cannot buy items" do
    seller = create :user, :seller
    invoice = create :invoice
    abilities = Ability.new seller 
    expect( abilities.can? :buy, invoice ).to be false
  end

  it "shoppers cannot post items" do
    shopper = create :user, :shopper
    item = create :item
    abilities = Ability.new shopper
    expect( abilities.can? :sell, Item ).to be false
  end

  it "shoppers can buy items" do
    shopper = create :user, :shopper
    invoice = create :invoice, user: shopper
    abilities = Ability.new shopper
    expect( abilities.can? :buy, invoice ).to be true
  end

  it "admins can suspend users" do 
    admin = create :user, :admin
    other_user = create :user, :shopper
    abilities = Ability.new admin
    expect( abilities.can? :ban, other_user ).to be true
  end 

  it "admins can delete posted items" do 
    admin = create :user, :admin
    abilities = Ability.new admin
    expect( abilities.can? :modify, Item ).to be true
  end

  it "sellers can delete posted items" do
    item = create :item
    item2 = create :item
    abilities = Ability.new item.seller 
    expect( abilities.can? :modify, item2 ).to be false
    expect( abilities.can? :modify, item ).to be true
  end
  
  it "banned users cannot post items" 
    
end
