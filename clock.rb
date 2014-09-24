require 'clockwork'

print 'Booting Rails ... '
require './config/boot'
require './config/environment'
puts 'done'

module Clockwork
  #every 1, 'tick.job' do
  #  puts 'tick'
  #end

  every 1.minute, 'mail.job' do
    MailReceiptWorker.perform_later Invoice.first
  end
end
