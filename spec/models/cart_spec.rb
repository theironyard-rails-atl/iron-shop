require 'rails_helper'

describe Cart do
  before :each do
    @shopper = create :user, :shopper
    @cart    = Cart.new @shopper
    [1.00, 5432.99, 161.8].each do |price|
      @cart.add( create :item, price: price )
    end
  end

  it 'knows how many items it contains' do
    expect( @cart.items.count ).to eq 3
  end

  it 'can compute the subtotal before tax' do
    expect( @cart.subtotal ).to eq 5595.79
  end

  it 'can compute the total with tax' do
    expect( @cart.tax_rate ).to eq 0.04
    expect( @cart.total ).to eq 5819.62
  end

  it 'can set a different tax rate' do
    @cart.tax_rate = 0.07
    expect( @cart.tax_rate ).to eq 0.07
    expect( @cart.total ).to eq 5987.50
  end

  it 'can checkout' do
    expect do
      @cart.checkout!
    end.to change { @shopper.invoices.count }.from(0).to(1)

    invoice = @shopper.invoices.last
    binding.pry
    expect( invoice.amount ).to eq @cart.total
    expect( invoice.paid? ).to eq false
  end

  it 'can apply coupons before checking out'
end
