module DotfilesAssertionsHelper

  class FakeHomeNotDefinedException < Exception; end

  def assert_file_install(file)
    assert(File.exists?(file))
  end

  def assert_set_installed(set)
    raise FakeHomeNotDefinedException unless defined?(@fake_home)
    set.each_value do |file|
      assert_file_install(File.join([@fake_home, file]))
    end
  end

end

require 'minitest/autorun'

require File.expand_path(File.join([File.dirname(__FILE__), "..", "dotfiles_installer"]))

Dir["./test/*_install_test.rb"].each do |f|
  require f
end
