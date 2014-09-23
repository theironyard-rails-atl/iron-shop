class CardProcessor
  def initialize invoice, token
    @invoice, @token = invoice, token
  end

  def process
    @customer = create_customer
    process_charge! @customer
    note_payment
    # print receipt?
    # send email?
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
    Stripe::Charge.create(
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
end
