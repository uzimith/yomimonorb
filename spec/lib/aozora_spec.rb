require 'spec_helper'
require 'aozora'

describe Aozora do
  before :each do
    url = "http://www.aozora.gr.jp/cards/000148/files/773_14560.html"
    @book = Aozora.new(url)
  end

  it "fetches from url" do
    expect(@book.fetch).to include "その人を常に先生と呼んでいた。"
  end

  it "show 0 ~ 140 charactor" do
    expect(@book.part(0,140)).to include "その人を常に先生と呼んでいた。"
  end

  it "show 140 ~ 280 charactor" do
    expect(@book.part(1,140)).to include "私が先生と知り合いになったのは鎌倉である。"
  end
end
