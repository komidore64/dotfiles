#!/usr/bin/env ruby

File.open(File.expand_path(File.join([File.dirname(__FILE__), "..", "Xdefaults"])), "r") do |file|
  file.read.split("\n").grep(/background|foreground|color/i).collect do |str|
    str.split(":").tap do |line|
      line[0] = line[0][6..-1]
      line[1] = line[1].strip
      line[2] = line[1].scan(/#(\w\w)(\w\w)(\w\w)/)[0].collect { |v| v.to_i(16).to_s(10).to_i }
    end
  end.each do |color|
    puts "#{color[0]}: #{color[1]}, #{color[2]}"
  end
end
