class InvoicesController < ApplicationController
  before_action :authenticate_user!

  def show
    @invoice = current_user.invoices.find params[:id]
  end

  def close
    @invoice = current_user.invoices.find params[:id]
    CardProcessor.new(@invoice, params[:stripeToken]).process

    flash[:success] = "Your purchase went through"
    redirect_to @invoice
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to @invoice
  end
end
