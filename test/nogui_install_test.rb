require 'fileutils'

class NoguiInstallTest < MiniTest::Unit::TestCase
  include DotfilesAssertionsHelper

  def setup
    this_file = File.expand_path(File.dirname(__FILE__))
    @fake_home = File.join([this_file, "nogui_fake_home"])
    FileUtils.mkdir(@fake_home) unless File.exists?(@fake_home)
  end

  def teardown
    FileUtils.rm_r(@fake_home) unless ENV['noclean']
  end

  def test_linux_install
    installation_sets = [:common]
    DotfilesInstaller.install_dotfiles(installation_sets, :root_dest => @fake_home)
    installation_sets.each do |set|
      assert_set_installed(DotfilesInstaller::FILES[set])
    end
  end

end
