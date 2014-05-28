require 'clockwork'
require_relative "lib/tweet"

unless ENV['Heroku']
  require_relative "debug"
end

module Clockwork
  handler do |job, at|
    Tweet.new.tweet
  end

  every(10.seconds, 'frequent.job')
end
