class CardProcessor
  attr_reader :charge

  # Refer to this as CardProcessor::ProcessingError
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
    send_receipt
    # print receipt?
  end

  class << self
    # ^- everything inside this block runs on the
    #   object's class

    def token_for_card card_number
      # v mimics what the checkout.js does to generate a token
      token = Stripe::Token.create(card: {
        number:    card_number,
        exp_month: 9,
        exp_year:  2015,
        cvc:       '112'
      })
      token.id
    end

    def valid_token
      token_for_card '4242424242424242'
    end

    def declined_token
      token_for_card '4000000000000002'
    end
  end

private

  def create_customer
    # Makes a POST call to create a Customer resource
    #   on the Stripe API
    Stripe::Customer.create(
      :email => @invoice.user.email,
      :card  => @token
    )
  end

  def process_charge! customer
    # Make a POST call to actually charge user's card
    @charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @invoice.amount_in_cents,
      :description => 'Iron Shop customer',
      :currency    => 'usd'
    )
  end

  def note_payment
    @invoice.paid = true
    @invoice.save!
  end

  def send_receipt
    # Deliver mail now, and wait to finish
    #InvoiceMailer.receipt(@invoice).deliver

    # Register that this needs to be sent, and do
    #   so when a worker is available
    MailReceiptWorker.perform_later @invoice
  end
end
