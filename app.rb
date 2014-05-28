require 'rubygems'
require 'clockwork'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(1.minutes, 'frequent.job')
end
