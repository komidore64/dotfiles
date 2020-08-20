# frozen_string_literal: true

require 'fileutils'
require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = ['test/helper.rb']
  t.options = '--verbose' if ENV['GITHUB_RUN_ID']
end

RuboCop::RakeTask.new(:lint) do |t|
  t.patterns = ['Rakefile', '*.rb', 'test/**/*.rb']
end

desc 'clean the test fake_dirs'
task :clean do
  test_dir = File.join(__dir__, 'test')
  Dir[File.join([test_dir, '*_install_test.rb'])].each do |path|
    scan = path.split('/').last.scan(/\A(.+)_install_test\.rb\z/)[0][0]
    fake_home = File.join([test_dir, "#{scan}_fake_home"])
    puts "removing #{fake_home}"
    FileUtils.rm_rf(fake_home)
  end
end

task default: %i[test lint]
