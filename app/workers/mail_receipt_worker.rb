class MailReceiptWorker
  include Sidekiq::Worker

  def perform invoice_id
    invoice = Invoice.find_by_id invoice_id
    return if invoice.nil?
    InvoiceMailer.receipt(invoice).deliver

  end
end
