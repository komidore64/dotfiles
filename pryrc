# -*- coding: utf-8 -*-
#
# ~/.pryrc

Pry.config.editor = "#{ENV['EDITOR']}"

begin
  require 'amazing_print'
  AmazingPrint.pry!
  puts 'amazing_print loaded'
rescue LoadError
end

begin
  require 'hirb'
  Hirb.enable
  puts 'hirb loaded'
rescue LoadError
end

%w(pry-debugger pry-byebug pry-stack_explorer pry-rescue).each do |lib|
  begin
    require lib
    puts "#{lib} loaded"
  rescue LoadError
  end
end

if defined?(PryDebugger) || defined?(PryByebug)
  Pry.commands.alias_command('cont', 'continue')
  Pry.commands.alias_command('f', 'finish')
  Pry.commands.alias_command('s', 'step')
  Pry.commands.alias_command('n', 'next')
  Pry.commands.alias_command('l', 'whereami')
end

# vim:ft=ruby
