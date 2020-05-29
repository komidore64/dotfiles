class LinuxInstallTest < MiniTest::Test
  include DotfilesAssertionsHelper

  def setup
    @fake_home = File.join([File.expand_path(File.dirname(__FILE__)), "linux_fake_home"])
    FileUtils.mkdir(@fake_home) unless File.exist?(@fake_home)
  end

  def teardown
    FileUtils.rm_r(@fake_home) unless ENV['noclean']
  end

  def test_linux_install
    installation_sets = [:common, :linux]
    Dotfiles::Installer.new(:destination_dir => @fake_home).install_dotfiles(installation_sets)
    installation_sets.each do |set|
      assert_set_installed(Dotfiles::Installer::FILES[set])
    end
  end

end
