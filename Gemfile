source 'https://rubygems.org'

gem 'twitter'
gem 'nokogiri'
gem 'clockwork'
gem "factory_girl"
gem "activerecord"

group :production do
  gem 'pg'
end

group :development do
  gem "byebug"
  gem "awesome_print"
  gem "terminal-notifier-guard"
  gem 'pry'
  gem "sqlite3"
end

group :test do
  gem "rack-test", group: 'development'
  gem 'rspec', '~> 3.0.0.rc1', group: 'development'
  gem 'guard', group: 'development'
  gem 'guard-rspec', group: 'development'
  gem "guard-bundler", group: 'development'
  gem 'database_cleaner', group: 'development'
end
