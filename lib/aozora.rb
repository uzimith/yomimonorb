require 'open-uri'
require "nokogiri"

class Aozora
  def initialize(url)
    @url = url
  end
  
  def fetch
    document = Nokogiri::HTML(open(@url))
    data = document.css("div.main_text")
    data.inner_html.encode("UTF-8")
  end
end
