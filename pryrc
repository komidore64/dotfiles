# ~/.pryrc
# vim:ft=ruby

Pry.config.editor = "#{ENV['EDITOR']}"

begin
  require "awesome_print"
  AwesomePrint.pry!
rescue LoadError
  puts "awesome_print not found. skipping..."
end

begin
  require 'hirb'
  Hirb.enable
rescue LoadError
  puts "hirb not found. skipping..."
end

%w(pry-debugger pry-stack_explorer pry-rescue).each do |lib|
  begin
    require lib
  rescue LoadError
    puts "#{lib} not found. skipping..."
  end
end

if defined?(PryDebugger)
  Pry.commands.alias_command('c', 'continue')
  Pry.commands.alias_command('cont', 'continue')
  Pry.commands.alias_command('s', 'step')
  Pry.commands.alias_command('n', 'next')
  Pry.commands.alias_command('f', 'finish')
  Pry.commands.alias_command('q', 'exit-all')
  Pry.commands.alias_command('l', 'whereami')
  Pry.commands.alias_command('jackout', 'disable-pry')
end
