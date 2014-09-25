class CardProcessor
  def initialize invoice, token
    @invoice, @token = invoice, token
  end

  def process
    customer = Stripe::Customer.create(
      :email => @invoice.shopper.email,
      :card  => @token
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @invoice.amount_in_cents,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
  end

  def send_receipt
    ## InvoiceMailler.receipt(@invoice).deliver
    MailReceiptWorker.perform_async @invoice.id
  end
end
