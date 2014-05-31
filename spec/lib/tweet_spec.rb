require 'spec_helper'
require 'tweet'
require './debug'

describe Tweet do

  it "connects to twitter" do
    class Tweet
      def confirm_client
        @client
      end
    end
    expect(Tweet.new.confirm_client.class).to eq Twitter::REST::Client
  end

  context "when call #mentions," do
    let(:bot_filename) {"bot_test.yml"}

    after :each do
      if File.exist? bot_filename
        File.unlink bot_filename
      end
    end

    it "fecths mentions only new mentions" do
      class Tweet
        def initialize(client,bot)
          @client = client
          @bot    = bot
        end
      end
      client = double "client", mentions_timeline: (3..5).map { |i|
        mention = double "mention",
          id:   i,
          user: double("user", id: i)
        expect(mention).to receive(:call).once
        mention
      }
      tweet = Tweet.new(client,Bot.new(bot_filename))
      tweet.mentions do |mention|
        mention.call
      end

      client = double "client", mentions_timeline: (1..5).map { |i|
        mention = double "mention",
          id:   i,
          user: double("user", id: i)
        if (1..2).include? i
          expect(mention).to receive(:call).once
        end
        mention
      }
      tweet = Tweet.new(client,Bot.new(bot_filename))
      tweet.mentions do |mention|
        mention.call
      end
    end
  end

  context "if user don't exists", focus: false do
    it "doesn't tweet" do
      class Tweet
        def initialize
          @client = get_client
          @bot = Bot.new
        end
      end

      Tweet.new.tweets
    end
  end

  context "if User exists,", focus: false do
    it "tweets" do
      User.create do |user|
        user.userid = 899718601
        user.count  = 0
        user.url    = "http://www.aozora.gr.jp/cards/000148/files/773_14560.html"
      end

      Tweet.new.tweets

      user = User.find_by_userid(899718601)
      expect(user.count).to eq 1
    end
  end

end
