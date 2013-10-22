require 'fileutils'

class NitrousInstallTest < MiniTest::Unit::TestCase

  def assert_file_install(file)
    assert(File.exists?(file))
  end

  def assert_set_installed(set)
    set.each_value do |file|
      assert_file_install(File.join([@fake_home, file]))
    end
  end

  def setup
    this_file = File.expand_path(File.dirname(__FILE__))
    @fake_home = File.join([this_file, "nitrous_fake_home"])
    FileUtils.mkdir(@fake_home) unless File.exists?(@fake_home)
  end

  def test_linux_install
    installation_sets = [:common, :nitrous]
    Derpfiles.install_dotfiles(installation_sets, :root_dest => @fake_home)
    installation_sets.each do |set|
      assert_set_installed(Derpfiles::FILES[set])
    end
  end

end
