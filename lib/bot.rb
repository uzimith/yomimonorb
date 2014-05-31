class Bot
  def initialize(filename = "bot.yml")
    @filename = filename
    if File.exist? @filename
      @config = YAML.load_file @filename
    else
      @config = {}
    end
  end

  def save
    open(@filename, "w") do |io|
      io.write @config.to_yaml
    end
  end

  def last_reply(id = nil)
    if id
      @config[:last_reply] = id
    else
      @config[:last_reply]
    end
  end
end
