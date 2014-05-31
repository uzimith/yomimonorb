require 'spec_helper'
require 'bot'

describe Bot do
  let(:filename) { 'bot_test.yml'}

  after :each do
    if File.exist? filename
      File.unlink filename
    end

  end

  it "saves" do
    bot = Bot.new(filename)
    bot.save
    expect(File.exist? filename).to be true
  end

  it "set last_reply" do
    bot = Bot.new(filename)
    bot.last_reply(1000)
    bot.save

    bot2 = Bot.new(filename)
    expect(bot2.last_reply).to be 1000
  end
end
