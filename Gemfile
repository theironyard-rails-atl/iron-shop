source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '4.2.0.beta1'
gem 'sass-rails', '~> 5.0.0.beta1'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'haml-rails'

gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'devise', git: 'https://github.com/plataformatec/devise.git', branch: 'lm-rails-4-2'
gem 'cancancan'

gem 'figaro'
gem 'stripe'

gem 'sidekiq'
gem 'sinatra'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'pry-rails'
  gem 'quiet_assets'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'sqlite3'
  gem 'factory_girl_rails', require: false
  gem 'faker'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'simplecov'
  gem 'vcr'
  gem 'webmock'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
end
