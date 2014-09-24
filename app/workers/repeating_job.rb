class RepeatingJob < ActiveJob::Base
  queue_as :default

  def perform
    RepeatingJob.set(wait: 2).perform_later

    # ` is Ruby for "execute in shell"
    `open http://edgecats.net`
  end
end
