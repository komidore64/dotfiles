#! /usr/bin/env ruby

# derpfiles - install your dotfiles
# Copyright (C) 2013 M. Adam Price
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see {http://www.gnu.org/licenses/}.

require 'fileutils'
require 'optparse'

module Derpfiles

  VERSION = "0.0.2"

  FILES = {
    :common => {
      "bash_colors" => ".bash_colors",
      "bashrc" => ".bashrc",
      "bash_logout" => ".bash_logout",
      "bin/asdf" => "bin/asdf",
      "bin/hub" => "bin/hub",
      "bin/fetch-all-git-repos" => "bin/fetch-all-git-repos",
      "bin/git-vim" => "bin/git-vim",
      "bin/quicksrv" => "bin/quicksrv",
      "bin/todo" => "bin/todo",
      "bin/vundle-update" => "bin/vundle-update",
      "completion" => ".completion",
      "gitconfig" => ".gitconfig",
      "git_template" => ".git_template",
      "pdbrc" => ".pdbrc",
      "pryrc" => ".pryrc",
      "rdebugrc" => ".rdebugrc",
      "rvm/gemsets/ruby/1.9.3/global.gems" => ".rvm/gemsets/ruby/1.9.3/global.gems",
      "rvm/gemsets/ruby/2.1.2/global.gems" => ".rvm/gemsets/ruby/2.1.2/global.gems",
      "rvmrc" => ".rvmrc",
      "tmux.conf" => ".tmux.conf",
      "tmuxinator" => ".tmuxinator",
      "vim" => ".vim",
      "vimrc" => ".vimrc",
      "vundle" => ".vundle",
      "weechat" => ".weechat"
    },
    :linux => {
      "bin/subl" => "bin/subl",
      "fonts" => ".fonts",
      "config/sublime-text-2" => ".config/sublime-text-2",
      "Xdefaults" => ".Xdefaults",
      "Xmodmap" => ".Xmodmap"
    },
    :osx => { # saving osx for later. just want to get this finished for now
      # "config/sublime-text-2" => "Library/Application\ Support/Sublime\ Text\ 2",
      # "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" => "bin/subl"
      "bash_profile" => ".bash_profile"
    },
    :nitrous => {
      "bin/nitrous-disk-usage" => "bin/nitrous-disk-usage",
      "timezone" => ".timezone"
    }
  }

  def self.install_dotfiles(sets, options = {})
    options = {
      :root_dest => ENV['HOME'],
      :root_src => File.expand_path("#{File.dirname(__FILE__)}/../") # root of the github repo
    }.merge(options)

    sets.each { |s| install_set(s, options[:root_src], options[:root_dest]) }
  end

  def self.prompt(message, default = nil)
    print("%s " % message)
    result = gets.chomp
    result.empty? ? default : result
  end

  def self.symlink(source, destination, exists = false)
    File.delete(destination) if exists
    File.symlink(source, destination)
  end

  def self.install_single(src, dest)
    dirs = dest.scan(/\A(.*)(\/.*)\z/)[0][0]
    overwrite = true
    if exists = File.exists?(dest)
      overwrite = case prompt("Overwrite #{dest} [y,N,q]?", "N")
                  when "Q", "q"
                    exit 0
                  when "Y", "y"
                    true
                  else
                    false
                  end
    end
    if overwrite
      FileUtils.makedirs(dirs) unless exists
      symlink(src, dest, exists)
    end
  end

  def self.install_set(set, root_src, root_dest)
    FILES[set].each do |k, v|
      install_single(File.join([root_src, k]), File.join([root_dest, v]))
    end
  end

end

if __FILE__ == $0

  options = {}
  optparse = OptionParser.new do |opts|

    # defaults
    options[:sets] = [:common, :linux]
    options[:flags] = []

    opts.banner = "USAGE: ruby #{__FILE__} [OPTIONS]"
    opts.version = "#{__FILE__} #{Derpfiles::VERSION} Copyright (C) 2013 M. Adam Price"

    opts.on("--linux", "install dotfiles for a linux system (default)") do
      options[:flags] << :linux
    end

    opts.on("--nitrous", "install dotfiles on a nitrous.io box") do
      options[:sets] << :nitrous
      options[:sets].delete(:linux)
      options[:flags] << :nitrous
    end

    opts.on("--nogui", "install dotfiles excluding those related to a graphical interface") do
      options[:sets].delete(:linux)
      options[:flags] << :nogui
    end

    opts.on("--osx", "install dotfiles for mac os x") do
      options[:sets].delete(:linux)
      options[:flags] << :osx
    end

  end

  begin
    optparse.parse!
    raise OptionParser::AmbiguousArgument, "can only supply one of [ --linux, --nitrous, --nogui, --osx ]" if options[:flags].size > 1
    Derpfiles.install_dotfiles(options[:sets])
  rescue OptionParser::AmbiguousArgument => e
    puts "#{e.message}\n\n#{optparse.help}"
    exit 1
  end

end
