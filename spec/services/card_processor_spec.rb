require 'rails_helper'

describe CardProcessor do
  before :each do
    @invoice = create :invoice
  end

  it 'marks the invoice as paid', :vcr do
    processor = CardProcessor.new @invoice, CardProcessor.valid_token
    processor.process

    expect( @invoice.paid? ).to be true

    charge = processor.charge
    expect( charge.id ).not_to be nil
    expect( charge.card.brand ).to eq 'Visa'

    # I enqueued a MailReceipt job
    expect( MailReceiptWorker.jobs.count ).to eq 1
    expect do
      MailReceiptWorker.drain # runs all the jobs for this worker
    end.to change{ ActionMailer::Base.deliveries.count }.from(0).to(1)

    # inline! test mode:
    # expect( ActionMailer::Base.deliveries.count ).to eq 1
  end

  it 'handles declined cards', :vcr do
    processor = CardProcessor.new @invoice, CardProcessor.declined_token
    expect do
      processor.process
    end.to raise_error CardProcessor::ProcessingError

    expect( @invoice.paid? ).to be false
  end
end
