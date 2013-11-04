# ~/.pryrc
# vim:ft=ruby

Pry.config.editor = "#{ENV['EDITOR']}"

begin
  require "awesome_print"
  AwesomePrint.pry!
rescue LoadError
  puts "awesome_print not found. skipping..."
end

if defined?(PryDebugger)
  Pry.commands.alias_command('c', 'continue')
  Pry.commands.alias_command('cont', 'continue')
  Pry.commands.alias_command('s', 'step')
  Pry.commands.alias_command('n', 'next')
  Pry.commands.alias_command('f', 'finish')
  Pry.commands.alias_command('q', 'exit-all')
end
