source 'https://rubygems.org'

gem 'hanami', '~> 1.3'
gem 'hanami-model', '~> 1.3'
gem 'i18n'
gem 'rake'

# Db
gem 'pg'
# Authentication
gem 'omniauth-google-oauth2'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'hanami-webconsole'
  gem 'shotgun', platforms: :ruby
end

group :test, :development do
  gem 'dotenv'
  gem 'overcommit'
  gem 'pry'
  gem 'rubocop'
end

group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'simplecov', require: false
end

group :production do
  # gem 'puma'
end
