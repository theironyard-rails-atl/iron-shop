class InvoicesController < ApplicationController
 def show
   @invoice = current_user.invoices.find params[:id]
 end
  
 def close 
 end
end
