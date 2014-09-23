require 'rails_helper'

describe CardProcessor do
  before :each do
    @invoice = create :invoice
  end

  it 'marks the invoice as paid' do
    processor = CardProcessor.new @invoice, CardProcessor.valid_token
    processor.process

    expect( @invoice.paid? ).to be true
  end

  it 'handles declined cards' do
    processor = CardProcessor.new @invoice, CardProcessor.declined_token
    expect do
      processor.process
    end.to raise_error Stripe::CardError

    expect( @invoice.paid? ).to be false
  end
end
