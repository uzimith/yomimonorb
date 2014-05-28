require 'twitter'

class Tweet
  def initialize()
    @text = <<-EOF.split("\n")
あいうえお
かきくけこ
さしすせそ
たちつてと
EOF
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['ConsumerKey']
      config.consumer_secret     = ENV['ConsumerSecret']
      config.access_token        = ENV['AccessToken']
      config.access_token_secret = ENV['AccessSecret']
    end
  end

  def tweet
  end

  private
  def update(tweet)
    return nil unless tweet
    begin
      Twitter.update(tweet.chomp)
    rescue => ex
    end
  end
end
