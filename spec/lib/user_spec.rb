require 'spec_helper'
require 'user'

describe User do
  it "#new" do
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
