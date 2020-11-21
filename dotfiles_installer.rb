# frozen_string_literal: true

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
  # Contains all functions for installing dotfiles
  class Installer
    VERSION = '0.0.5'

    FILES = {
      common: {
        'bash_colors' => '.bash_colors',
        'bashrc' => '.bashrc',
        'bin/asdf' => 'bin/asdf',
        'bin/git-oldest-ancestor' => 'bin/git-oldest-ancestor',
        'bin/tiga' => 'bin/tiga',
        'bin/vundle-update' => 'bin/vundle-update',
        'gitconfig' => '.gitconfig',
        'pryrc' => '.pryrc',
        'pythonrc' => '.pythonrc',
        'rvm/gemsets/ruby/2.1.2/global.gems' => '.rvm/gemsets/ruby/2.1.2/global.gems',
        'rvmrc' => '.rvmrc',
        'tigrc' => '.tigrc',
        'vim' => '.vim',
        'vimrc' => '.vimrc',
        'vundle' => '.vundle',
        'weechat' => '.weechat'
      },
      linux: {
        'fonts' => '.fonts',
        'config/kitty' => '.config/kitty',
        'config/sublime-text-3' => '.config/sublime-text-3',
        'Xmodmap' => '.Xmodmap'
      }
    }.freeze

    attr_reader :write_action, :destination_dir, :source_dir

    def initialize(options = {})
      options = {
        write_action: 'prompt',
        destination_dir: ENV['HOME'],
        source_dir: File.expand_path(`git rev-parse --show-toplevel`.strip)
      }.merge(options)

      self.write_action = options[:write_action]
      self.source_dir = options[:source_dir]
      self.destination_dir = options[:destination_dir]
    end

    def write_action=(action)
      unless action.match(/\A(overwrite|no[_-]overwrite|prompt)\z/)
        raise 'write action must be one of [ overwrite, no-overwrite, prompt ]'
      end

      @write_action = action.tr('-', '_')
    end

    def source_dir=(src_dir)
      raise "not a valid source directory [ #{src_dir} ]" unless File.directory?(src_dir)

      @source_dir = src_dir
    end

    def destination_dir=(dest_dir)
      raise "not a valid destination directory [ #{dest_dir} ]" unless File.directory?(dest_dir)

      @destination_dir = dest_dir
    end

    def install_dotfiles(sets)
      sets.each { |s| install_set(s, @source_dir, @destination_dir) }
    end

    private

    def prompt(message, default = nil)
      print("#{message} ")
      result = gets.chomp
      result.empty? ? default : result
    end

    def symlink(src, dest, options = {})
      options = { delete: false }.merge(options)

      File.delete(dest) if options[:delete]
      File.symlink(src, dest)
    end

    def overwrite_prompt(src, dest)
      case prompt("Overwrite #{dest} [y,N,q]?", 'N')
      when 'Q', 'q'
        exit 0
      when 'Y', 'y'
        symlink(src, dest, delete: true)
      end
    end

    def install_single_with_prexisting_file(src, dest)
      case @write_action
      when 'prompt'
        overwrite_prompt(src, dest)
      when 'overwrite'
        symlink(src, dest, delete: true)
      end
    end

    def install_single_newfile(src, dest)
      dir = dest.scan(%r{\A(.*)(/.*)\z})[0][0]
      FileUtils.makedirs(dir)
      symlink(src, dest)
    end

    def install_single(src, dest)
      raise "source file does not exist [ #{src} ]" unless File.exist?(src)

      if File.exist?(dest)
        install_single_with_prexisting_file(src, dest)
      else
        install_single_newfile(src, dest)
      end
    end

    def install_set(set, src_dir, dest_dir)
      FILES[set].each do |repo_path, install_path|
        install_single(File.join([src_dir, repo_path]), File.join([dest_dir, install_path]))
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME

  options = {}
  optparse = OptionParser.new do |opts|
    # defaults
    options[:sets] = %i[common linux]
    options[:select1] = 0
    options[:select2] = 0

    opts.banner = "USAGE: ruby #{__FILE__} [OPTIONS]"
    opts.version = "#{__FILE__} #{Dotfiles::Installer::VERSION} Copyright (C) #{Time.new.year} M. Adam Price"

    linux_msg = 'install dotfiles for a linux system (default)'
    opts.on('--linux', linux_msg) do
      options[:sets] = %i[common linux]
      options[:select1] += 1
    end

    nogui_msg = 'install dotfiles excluding those related to a graphical interface'
    opts.on('--nogui', nogui_msg) do
      options[:sets] = %i[common]
      options[:select1] += 1
    end

    write_msg = 'use [ overwrite, no-overwrite, prompt ] to specify write-action when an existing dotfile is found'
    opts.on('--write-action ACTION', write_msg) do |action|
      options[:write_action] = action
    end
  end

  begin
    optparse.parse!
    raise OptionParser::AmbiguousArgument, 'can only supply one of [ --linux, --nogui ]' if options[:select1] > 1

    Dotfiles::Installer.new(options).install_dotfiles(options[:sets])
  rescue OptionParser::AmbiguousArgument => e
    puts "#{e.message}\n\n#{optparse.help}"
    exit 1
  rescue RuntimeError => e
    puts e.message
    exit 1
  end

end
