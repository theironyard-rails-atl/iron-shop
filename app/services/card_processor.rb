class CardProcessor
  def initialize invoice, token
    @invoice, @token = invoice, token
  end

  def process
    customer = Stripe::Customer.create(
      :email => @invoice.user.email,
      :card  => @token
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @invoice.amount_in_cents,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
  end
end
