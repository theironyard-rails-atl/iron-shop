Devise::Async.setup do |config|
  config.enabled = true # | false
  config.backend = :sidekiq # default is :resque
end
