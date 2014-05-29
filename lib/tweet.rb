require 'twitter'
require_relative 'aozora'
require_relative 'user'

class Tweet
  def initialize()
    @client = client
  end

  def tweets
    User.find_all do |user|
      @client.mention(user)
    end
  end

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['ConsumerKey']
      config.consumer_secret     = ENV['ConsumerSecret']
      config.access_token        = ENV['AccessToken']
      config.access_token_secret = ENV['AccessSecret']
    end
  end

  private
  def update(tweet)
    return nil unless tweet
    begin
      Twitter.update(tweet.chomp)
    rescue => e
      p e
    end
  end

  def mentionAozora(user)
  end
end
