class InvoicesController < ApplicationController
  def show
    @invoice = current_user.invoices.find params[:id]
  end

  def close
    @invoice = current_user.invoices.find params[:id]

    # Makes a POST call to create a Customer resource
    #   on the Stripe API
    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
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

    flash[:success] = "Your purchase went through"
    redirect_to @invoice

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to @invoice
  end
end
