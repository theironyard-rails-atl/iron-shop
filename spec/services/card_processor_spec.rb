require 'rails_helper'

describe CardProcessor do
  before :each do
    @invoice = create :invoice
  end

  it 'marks the invoice as paid' do
    # v mimics what the checkout.js does to generate a token
    token = Stripe::Token.create(card: {
      number:    '4242424242424242',
      exp_month: 9,
      exp_year:  2015,
      cvc:       '112'
    })

    processor = CardProcessor.new @invoice, token.id
    processor.process

    expect( @invoice.paid? ).to be true
  end

  it 'handles declined cards' do
    token = Stripe::Token.create(card: {
      number:    '4000000000000002',
      exp_month: 9,
      exp_year:  2015,
      cvc:       '112'
    })

    processor = CardProcessor.new @invoice, token.id
    expect do
      processor.process
    end.to raise_error Stripe::CardError

    expect( @invoice.paid? ).to be false
  end
end