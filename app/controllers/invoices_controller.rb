  #before_action :get_cart #only: [:show_cart, :add_to_cart]
class InvoicesController < ApplicationController

  before_action :authenticate_user!
  before_action :get_invoice, only: [:show]
  
 def show
   #show invoice
   authorize! :buy, @invoice
 end
  
 def show_cart
   authorize! :buy, @cart
 end

 def add_to_cart
   @cart.add params[:item_id]
   redirect_to :back
 end

 def close 
   authorize! :buy, @cart
   @cart.total
   begin
     CardProcessor.new(@cart, params[:stripeToken]).process
     flash[:success] = "Your purchase was successful"
     @cart.checkout
   rescue CardProcessor::ProcessingError => e
     flash[:error] = e.message
   end
   redirect_to @cart
 end
 
 private

 def get_invoice
  @invoice = current_user.invoices.find(params[:id])
 end

 #def get_cart
   #@cart = current_user.invoices.where(cart_active: true ) 
   #Invoice.create(user: current_user) unless @cart
 #end
end
