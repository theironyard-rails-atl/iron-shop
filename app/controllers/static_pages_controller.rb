class StaticPagesController < ApplicationController
  def home
    @invoices = Invoice.all
  end
end
