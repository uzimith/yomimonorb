require 'spec_helper'
require 'tweet'
require './debug'

describe Tweet do
  it "can connect" do
    client = Tweet.new.client
    expect(client.class).to eq Twitter::REST::Client
  end
end
