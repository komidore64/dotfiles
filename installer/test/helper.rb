require 'minitest/autorun'

load File.expand_path(File.join([File.dirname(__FILE__), "..", "derpfiles"]))

Dir["./test/*_install_test.rb"].each do |f|
  require f
end
