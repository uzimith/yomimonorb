require 'twitter'
require_relative 'aozora'
require_relative 'user'
require_relative 'bot'

class Tweet
  def initialize
    @client = get_client
    @bot = Bot.new
  end

  def mentions
    mentions = @client.mentions_timeline
    index = mentions.find_index { |mention| mention.id === @bot.last_reply }
    index = (index ? index : mentions.length) - 1
    mentions[0..index].reverse.each do |mention|
      yield mention if block_given?
    end
    @bot.last_reply(mentions.first.id)
    @bot.save
  end

  def tweets
    User.find_each do |user|
      mentionAozora(user)
    end
  end


  private

  def get_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['ConsumerKey']
      config.consumer_secret     = ENV['ConsumerSecret']
      config.access_token        = ENV['AccessToken']
      config.access_token_secret = ENV['AccessSecret']
    end
  end


  def update(tweet)
    return nil unless tweet
    begin
      @client.update(tweet.chomp)
    rescue => e
      p e
    end
  end

  def mentionAozora(user)
    screen_name = @client.user(user.userid).screen_name
    aozora = Aozora.new user.url

    charactor = 140 - "@".length - screen_name.length - " ".length
    update "@#{screen_name} " + aozora.part(user.count, charactor)
    user.count += 1
    user.save
  end
end
