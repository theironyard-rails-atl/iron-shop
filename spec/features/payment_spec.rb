require 'rails_helper'

feature 'Payments', :js do
  before :each do
    @user = create :user
    login @user

    @invoice = create :invoice, amount: 123.45, user: @user
    visit invoice_path(@invoice)
  end

  it 'lets a user make a payment', :vcr do
    expect( page ).to have_content '123.45'
    first('.stripe-button-el').click

    Capybara.within_frame 'stripe_checkout_app' do
      fill_in 'Email', with: 'test@example.com'

      # Ugly hack to get around JS-formatting race conditions
      card = find('#card_number').native
      4.times do
        card.send_keys '4242'
        sleep 0.1
      end

      date = find('#cc-exp').native
      date.send_keys '11'
      sleep 0.1
      date.send_keys '14'

      fill_in 'CVC', with: '123'

      click_button 'Pay $123.45'
    end

    # Ewwww ...
    sleep 2

    expect( page ).to have_content 'Your purchase went through'

    @invoice.reload
    expect( @invoice.paid? ).to be true
  end
end
