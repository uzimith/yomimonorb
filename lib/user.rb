require "active_record"
require 'twitter'
require 'uri'
require 'net/http'
require_relative 'tweet'

class String
  def fetch_url(expand = true)
    return unless result = URI.regexp(%w[http https]).match(self)
    shorten_url = result[0]
    if expand
      shorten_url.expand_url
    else
      shorten_url
    end
  end

  def expand_url
    uri = URI(self)
    Net::HTTP.new(uri.host, uri.port).get(uri.path).header['location']
  end
end

class User < ActiveRecord::Base

  def self.update_by_tweet(tweet)
    user = self.find_by_userid(tweet.user.id)
    if user
      user.update_attribute :url, tweet.text.fetch_url
    else
      self.create do |u|
        u.userid = tweet.user.id
        u.url = tweet.text.fetch_url
        u.count = 0
      end
    end
  end

  def self.update_by_mentions
    Tweet.new.mentions do |mention|
      if mention.text.fetch_url
        update_by_tweet mention
      end
    end
  end

end
