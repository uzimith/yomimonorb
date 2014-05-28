require 'twitter'
require 'yaml'
class Tweet

  BaseDir = Dir::getwd + '/'

  def initialize(config_file = BaseDir + "config.yaml")
    @text = <<-EOF.split("\n")
あいうえお
かきくけこ
さしすせそ
たちつてと
EOF
    open(config_file) do |io|
      @config = YAML.load(io)
    end

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = @config['oauth']['ConsumerKey']
      config.consumer_secret     = @config['oauth']['ConsumerSecret']
      config.access_token        = @config['oauth']['AccessToken']
      config.access_token_secret = @config['oauth']['AccessSecret']
    end
  end
  def random_tweet
    tweet = @text[rand(@text.length)]
    @client.update(tweet)
  end

  private
  def update(tweet)
    return nil unless tweet
    begin
      Twitter.update(tweet.chomp)
    rescue => ex
      nil
    end
  end
end
