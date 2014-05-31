require 'spec_helper'
require 'user'

describe User do
  describe "update by tweet" do
    context "#create" do
      it "create to database" do
        User.create do |user|
          user.userid = 899718601
          user.count  = 0
          user.url    = "http://example/"
        end
        made_user = User.find_by_id(1)
        expect(made_user.userid).to eq 899718601
        expect(made_user.count).to eq 0
        expect(made_user.url).to eq "http://example/"
      end
    end

    context "#fetch_url", focus: false do
      let(:text) {"@yomimonorb http://t.co/VEeJObtJNY"} #
      
      it "fetch url from mention" do
        expect(text.fetch_url false).to eq "http://t.co/VEeJObtJNY"
      end

      it "expand url from shorten url" do
        expect(text.fetch_url).to eq "http://www.aozora.gr.jp/cards/000148/files/773_14560.html"
      end
    end

    context "#update_by_tweet" do
      let(:mention) do
        double "mention",
          id:   1000,
          text: "@yomimonorb http://t.co/VEeJObtJNY",
          user: double("user", id: 10)
      end

      it "creates" do
        User.update_by_tweet(mention)
        user = User.find_by_userid(10)
        expect(user.userid).to eq 10
        expect(user.url).to eq "http://www.aozora.gr.jp/cards/000148/files/773_14560.html"
        expect(user.count).to eq 0
      end
    end
  end
end
