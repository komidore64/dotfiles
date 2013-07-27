# urxvt_color_values.rb

def rgb(hexcolor)
    hexcolor.delete("#").scan(/../).collect { |c| convert(c).to_i }
end

def convert(color_channel)
    color_channel.to_i(16).to_s(10)
end

if __FILE__ == $0

  require 'pp'

  script_location = File.expand_path(__FILE__)

  xdefaults = File.expand_path("#{script_location}/../../../Xdefaults")

  contents = nil
  File.open(xdefaults, "r") do |f|
    contents = f.read.split("\n")
  end

  colors = contents.grep(/urxvt/i).grep(/(background|foreground|color)/i)

  colors.collect! do |line|
    parts = line.split
    hash = { parts[0].match(/\AURxvt\.(.*):\z/)[1] => rgb(parts[1]) }
    hash
  end

  # print them one line at a time
  colors.each do |c|
    puts c.inspect
    gets
  end

end
