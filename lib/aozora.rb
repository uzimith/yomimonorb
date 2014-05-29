require 'open-uri'
require "nokogiri"

class Aozora
  def initialize(url)
    @url = url
  end
  
  def fetch
    document = Nokogiri::HTML(open(@url))
    data = document.css("div.main_text")
    convert data.text
  end

  def part(num, charactor = 140)
    fetch[num*charactor...(num+1)*charactor]
  end

  private
  def convert(data)
    data.gsub!(/(\r\n|\r|\n| |　)/,"")
    data.gsub!(/\（.*?\）/,"")
  end
end
