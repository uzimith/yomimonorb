require "rubygems"
require_relative "lib/tweet"
require_relative "lib/user"
 
unless ENV['Heroku']
  require_relative "debug"
end
 
module Clockwork
  handler do |job, at|
    case job
    when 'frequent.job'
      Tweet.new_mention do |mention|
        User.create_by_tweet(mention)
      end
    when 'less.frequent.job'
      Tweet.tweets
    end
  end
 
  every(10.seconds, 'frequent.job')
  every(1.minutes, 'less.frequent.job')
end
