require 'spec_helper'
require 'aozora'

describe Aozora do
  it "can fetch from url" do
    url = "http://www.aozora.gr.jp/cards/000119/files/624_14544.html"
    book = Aozora.new(url)
    expect(book.fetch).to include "隴西"
  end
end
