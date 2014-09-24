class InvoicesController < ApplicationController

  before_action :authenticate_user!
  before_action :get_invoice 
  
 def show
   authorize! :buy, @invoice
 end
  
 def close 
   authorize! :buy, @invoice
   begin
     CardProcessor.new(@invoice, params[:stripeToken]).process
     flash[:success] = "Your purchase was successful"
   rescue CardProcessor::ProcessingError => e
     flash[:error] = e.message
   end
   redirect_to @invoice
 end
 
 private

 def get_invoice
  @invoice = current_user.invoices.find(params[:id])
 end
end
