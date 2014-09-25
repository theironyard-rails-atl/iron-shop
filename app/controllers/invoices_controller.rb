class InvoicesController < ApplicationController
  def show
    @invoice = current_user.invoices.find params[:id]
  end

  def close
    @invoice = current_user.invoices.find params[:id]
    CardProcessor.new( @invoice, params[:stripeToken] ).process

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
