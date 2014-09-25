class InvoiceMailer < ActionMailer::Base
  default from: 'receipts@iron-shop.example.com'
  def receipt invoice
    @invoice = invoice
    mail to: invoice.shopper.email, subject: "Receipt for purchase on; #{invoice.created_at}"
  end
end
