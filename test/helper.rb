# frozen_string_literal: true

module DotfilesAssertionsHelper
  class FakeHomeNotDefinedException < RuntimeError; end

  def assert_file_install(file)
    assert(File.exist?(file))
  end

  def assert_set_installed(set)
    raise FakeHomeNotDefinedException unless defined?(@fake_home)

    set.each_value do |file|
      assert_file_install(File.join([@fake_home, file]))
    end
  end
end

require 'minitest/autorun'

require_relative '../dotfiles_installer'

require 'linux_install_test'
require 'nogui_install_test'
