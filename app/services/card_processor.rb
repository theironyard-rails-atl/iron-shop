class CardProcessor
  attr_reader :charge

  class ProcessingError < StandardError ; end

  def initialize invoice, token
    @invoice, @token = invoice, token
  end

  def process
    begin 
      @customer = create_customer
      process_charge! @customer
    rescue Stripe::CardError => e
      raise ProcessingError, e.message
    end
    note_payment
    #TODO email, show receipt
  end

  def self.token_for_card card_number
    token = Stripe::Token.create(card: {
            number:    card_number,
            exp_month: 9,
            exp_year:  2015,
            cvc:       '112'
          })
          token.id
  end

  def self.valid_token
    token_for_card '4242424242424242'
  end

  def self.declined_token
    token_for_card '4000000000000002'
  end

  private

  def create_customer
    Stripe::Customer.create(
    :email => @invoice.user.email,
    :card => @token
    )
  end

  def process_charge! customer
    @charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => @invoice.amount_in_cents,
      :description => 'Iron Shop Customer',
      :currency => 'usd'
    )
  end

  def note_payment
    @invoice.paid = true
    @invoice.save!
  end
end
