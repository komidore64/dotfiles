# ~/.pryrc
# vim:ft=ruby

Pry.config.editor = "#{ENV['EDITOR']}"

begin
  require "awesome_print"
  AwesomePrint.pry!
rescue LoadError
  puts "awesome_print not found"
end
