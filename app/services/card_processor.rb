class CardProcessor
  def initialize invoice, token
    @invoice, @token = invoice, token
  end

  def process
    # Makes a POST call to create a Customer resource
    #   on the Stripe API
    customer = Stripe::Customer.create(
      :email => @invoice.user.email,
      :card  => @token
    )

    # Make a POST call to actually charge user's card
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @invoice.amount_in_cents,
      :description => 'Iron Shop customer',
      :currency    => 'usd'
    )

    @invoice.paid = true
    @invoice.save!
  end
end
