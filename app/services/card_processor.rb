class CardProcessor
  class ProcessingError < StandardError ; end

  def initialize invoice, token
    @invoice, @token = invoice, token
  end

  def process
    begin
      @customer = create_Stripe_customer
      process_charge! @customer
    rescue Stripe::CardError => e
      raise ProcessingError, e.message
    end
    note_payment
  end

  def create_Stripe_customer
    customer = Stripe::Customer.create(
      :email => @invoice.shopper.email,
      :card  => @token
    )
  end

  def process_charge! customer
    charge = Stripe::Charge.create(
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
    ## InvoiceMailler.receipt(@invoice).deliver
    MailReceiptWorker.perform_async @invoice.id
  end
end
