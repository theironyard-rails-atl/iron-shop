class MailReceiptWorker
  include Sidekiq::Worker

  def perform invoice_id
    # Invoice.where(id: invoice_id).first
    # Ensure data is up to date by fetching current
    invoice = Invoice.find_by_id invoice_id
    return if invoice.nil?

    InvoiceMailer.receipt(invoice).deliver
  end
end
