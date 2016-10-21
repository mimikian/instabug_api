source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.11'
# Use mysql2 as the database for Active Record
gem 'mysql2', '~> 0.3.18'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc
# Use puma as the app server
gem 'puma'
# figaro to securely configure the app
gem "figaro"
# versionist to support multiple versions for the API
gem 'versionist'
# Tire for elsaticsearch
gem 'tire'
# will_paginate
gem 'will_paginate'
# dalli for memacached
gem 'dalli'
# bunny for rabbitmq - publisher
gem "bunny", ">= 2.6.0"
# sneakers for rabbitmq - worker
gem 'sneakers'
# RABL for generating JSON
gem 'rabl'
gem 'oj'

group :development do
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug'
end

group :test do
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem 'shoulda-matchers', '~> 3.1'
  gem 'guard-rspec'
  gem 'database_cleaner'
end
