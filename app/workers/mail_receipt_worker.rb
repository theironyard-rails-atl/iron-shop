class MailReceiptWorker < ActiveJob::Base
  queue_as :default

  def perform invoice
    InvoiceMailer.receipt(invoice).deliver
  end
end
