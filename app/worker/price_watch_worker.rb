class PriceWatchWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    hourly.minute_of_hour( *(0..59).to_a )
  end

  def perform
    User.find_each do |user|
      watches = user.watch_notifications
      unless watches.empty?
        UserMailer.price_watch_email(user, watches).deliver
        watches.each do |watch|
          watch.destroy
        end
      end
    end
  end

end
