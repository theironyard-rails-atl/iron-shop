class InvoiceMailer < ActionMailer::Base
  default from: 'receipts@iron-shop.example.com'
  def receipt invoice
    mail to: invoice.user.email, subject: "Receipt for purchase on; #{invoice.created_at}"
  end
end
