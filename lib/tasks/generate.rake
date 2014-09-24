desc 'Generate a collection of fake data'
task :generate => :environment do
  require 'factory_girl_rails'

  items = []

  puts 'Creating sellers and items'
  rand(2..4).times.map do
    seller = FactoryGirl.create :user, :seller
    rand(1..10).times do
      items << FactoryGirl.create(:item, seller: seller)
    end
  end

  puts 'Creating shoppers and invoices'
  rand(5 * User.where(role: :shopper).count .. 30).times.map do
    buyer = FactoryGirl.create :user, :shopper
    rand(1..4).times do
      invoice = FactoryGirl.create(:invoice, user: buyer)
      rand(1..6).times { invoice.items << items.sample }
    end
  end

  puts 'Updating invoice prices'
  Invoice.find_each do |invoice|
    invoice.amount = invoice.items.map(&:price).reduce(&:+)
    invoice.save!
  end

end
