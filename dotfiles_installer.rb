#! /usr/bin/env ruby

# dotfiles_installer - install your dotfiles
# Copyright (C) 2020 M. Adam Price
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

module Dotfiles

  class Installer

    VERSION = "0.0.4"

    FILES = {
      :common => {
        "bash_colors" => ".bash_colors",
        "bashrc" => ".bashrc",
        "bash_logout" => ".bash_logout",
        "bin/asdf" => "bin/asdf",
        "bin/beat-time" => "bin/beat-time",
        "bin/fetch-all-git-repos" => "bin/fetch-all-git-repos",
        "bin/git-oldest-ancestor" => "bin/git-oldest-ancestor",
        "bin/git-vim" => "bin/git-vim",
        "bin/kojikat" => "bin/kojikat",
        "bin/ktest" => "bin/ktest",
        "bin/pulp-bounce" => "bin/pulp-bounce",
        "bin/pulp-clear" => "bin/pulp-clear",
        "bin/quicksrv" => "bin/quicksrv",
        "bin/tiga" => "bin/tiga",
        "bin/vundle-update" => "bin/vundle-update",
        "gitconfig" => ".gitconfig",
        "pryrc" => ".pryrc",
        "pythonrc" => ".pythonrc",
        "rvm/gemsets/ruby/2.1.2/global.gems" => ".rvm/gemsets/ruby/2.1.2/global.gems",
        "rvmrc" => ".rvmrc",
        "tigrc" => ".tigrc",
        "tmux.conf" => ".tmux.conf",
        "vim" => ".vim",
        "vimrc" => ".vimrc",
        "vundle" => ".vundle",
        "weechat" => ".weechat"
      },
      :linux => {
        "fonts" => ".fonts",
        "config/sublime-text-2" => ".config/sublime-text-2",
        "Xmodmap" => ".Xmodmap",
      }
    }

    attr_reader :write_action, :destination, :source

    def initialize(options = {})
      options = {
        :write_action => "prompt",
        :destination => ENV['HOME'],
        :source => File.expand_path(`git rev-parse --show-toplevel`.strip)
      }.merge(options)

      self.write_action = options[:write_action]
      self.source = options[:source]
      self.destination = options[:destination]
    end

    def write_action=(action)
      unless action.match(/\A(overwrite|no[_-]overwrite|prompt)\z/)
        fail RuntimeError,  "write action must be one of [ overwrite, no-overwrite, prompt ]"
      end

      @write_action = action.tr('-', '_')
    end

    def source=(src)
      unless File.exist?(src) && File.directory?(src)
        fail RuntimeError, "not a valid source directory [ #{src} ]"
      end

      @source = src
    end

    def destination=(dest)
      unless File.exist?(dest) && File.directory?(dest)
        fail RuntimeError, "not a valid destination directory [ #{dest} ]"
      end

      @destination = dest
    end

    def install_dotfiles(sets)
      sets.each { |s| install_set(s, @source, @destination) }
    end

    private

    def prompt(message, default = nil)
      print("%s " % message)
      result = gets.chomp
      result.empty? ? default : result
    end

    def symlink(src, dest, options = {})
      options = {:delete => false}.merge(options)

      File.delete(dest) if options[:delete]
      File.symlink(src, dest)
    end

    def overwrite_prompt(src, dest)
      case prompt("Overwrite #{dest} [y,N,q]?", "N")
      when "Q", "q"
        exit 0
      when "Y", "y"
        symlink(src, dest, :delete => true)
      else
        return # do nothing
      end
    end

    def install_single_with_prexisting_file(src, dest)
      case @write_action
      when 'no_overwrite'
        return
      when 'prompt'
        overwrite_prompt(src, dest)
      when 'overwrite'
        symlink(src, dest, :delete => true)
      end
    end

    def install_single_newfile(src, dest)
        dir = dest.scan(/\A(.*)(\/.*)\z/)[0][0]
        FileUtils.makedirs(dir)
        symlink(src, dest)
    end

    def install_single(src, dest)
      if File.exist?(dest)
        install_single_with_prexisting_file(src, dest)
      else
        install_single_newfile(src, dest)
      end
    end

    def install_set(set, root_src, root_dest)
      FILES[set].each do |k, v|
        install_single(File.join([root_src, k]), File.join([root_dest, v]))
      end
    end
  end

end

if __FILE__ == $0

  options = {}
  optparse = OptionParser.new do |opts|

    # defaults
    options[:sets] = [:common, :linux]
    options[:select1] = 0
    options[:select2] = 0

    opts.banner = "USAGE: ruby #{__FILE__} [OPTIONS]"
    opts.version = "#{__FILE__} #{Dotfiles::Installer::VERSION} Copyright (C) #{Time.new.year} M. Adam Price"

    opts.on("--linux", "install dotfiles for a linux system (default)") do
      options[:sets] = [:common, :linux]
      options[:select1] += 1
    end

    opts.on("--nogui", "install dotfiles excluding those related to a graphical interface") do
      options[:sets] = [:common]
      options[:select1] += 1
    end

    opts.on("--write-action ACTION", "use [ overwrite, no-overwrite, prompt ] to specify write-action when an existing dotfile is discovered") do |action|
      options[:write_action] = action
    end

  end

  begin
    optparse.parse!
    fail OptionParser::AmbiguousArgument, "can only supply one of [ --linux, --nogui ]" if options[:select1] > 1
    Dotfiles::Installer.new(options).install_dotfiles(options[:sets])
  rescue OptionParser::AmbiguousArgument => e
    puts "#{e.message}\n\n#{optparse.help}"
    exit 1
  end

end
