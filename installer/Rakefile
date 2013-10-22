require 'rake/testtask'
require 'fileutils'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = [ "test/helper.rb" ]
end

desc "clean the test fake_dirs"
task :clean do
  test_dir = File.join([File.expand_path(File.dirname(__FILE__)), "test"])
  Dir[File.join([test_dir, "*_install_test.rb"])].each do |path|
    scan = path.split("/").last.scan(/\A(.+)_install_test\.rb\z/)[0][0]
    fake_home = File.join([test_dir, "#{scan}_fake_home"])
    puts "removing #{fake_home}"
    FileUtils.rm_rf(fake_home)
  end
end

task :default => :test
