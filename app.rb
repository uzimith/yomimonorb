require "rubygems"
require "clockwork"
require "logger"
require_relative "lib/tweet"
require_relative "lib/user"
# require 'awesome_print'
# require "byebug"

## twitter
unless ENV['Heroku']
  require_relative "debug"
end

## database
ENV["ENV"] ||= 'development'
config = YAML.load_file 'config.yml'
ActiveRecord::Base.establish_connection config['database'][ENV['ENV']]

module Clockwork
  handler do |job, at|
    case job
      when 'frequent.job'
        User.update_by_mentions
      when 'less.frequent.job'
        Tweet.new.tweets
    end
  end

  every(1.minutes, 'frequent.job')
  every(1.hour, 'less.frequent.job')
end
