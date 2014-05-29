require "rubygems"
require_relative "lib/tweet"
 
unless ENV['Heroku']
  require_relative "debug"
end
 
module Clockwork
  handler do |job, at|
    Tweet.new.tweet
  end
 
  every(30.seconds, 'frequent.job')
end
