class InvoicesController < ApplicationController
  before_action :authenticate_user!

  def show
    @invoice = current_user.invoices.find params[:id]
  end

  def close
    @invoice = current_user.invoices.find params[:id]

    begin
      CardProcessor.new(@invoice, params[:stripeToken]).process
      flash[:success] = "Your purchase went through"
    rescue CardProcessor::ProcessingError => e
      flash[:error] = e.message
    end
    redirect_to @invoice
  end
end
