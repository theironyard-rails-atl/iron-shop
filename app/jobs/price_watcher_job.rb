require 'sucker_punch'

class PriceWatcherJob
  include SuckerPunch::Job

  def perform(watched_item, user)
    ItemMailer.price_watch(watched_item, user).deliver
  end
end
