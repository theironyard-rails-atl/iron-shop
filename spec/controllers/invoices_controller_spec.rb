require 'rails_helper'

describe InvoicesController do
  before :each do
    @invoice = create :invoice
    sign_in @invoice.user
  end

  it 'takes a valid payment' do
    post :close, id: @invoice.id, stripeToken: CardProcessor.valid_token
    # @invoice = Invoice.find @invoice.id
    @invoice.reload # <- go back to DB and make sure we're up to date

    expect( flash[:success] ).to eq 'Your purchase went through'
    expect( @invoice.paid? ).to be true
  end

  it 'notifies on payment failure' do
    post :close, id: @invoice.id, stripeToken: CardProcessor.declined_token
    @invoice.reload

    expect( flash[:error] ).to eq 'Your card was declined.'
    expect( @invoice.paid? ).to be false
  end
end
