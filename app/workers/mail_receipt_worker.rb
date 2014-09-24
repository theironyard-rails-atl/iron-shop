class MailReceiptWorker
  include Sidekiq::Worker

  def perform invoice_id
    invoice = Invoice.find invoice_id
    InvoiceMailer.receipt(invoice).deliver
  end
end
