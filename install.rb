#!/usr/bin/env ruby
# -*- mode: ruby; coding: utf-8 -*-
require 'fileutils'

puts `git submodule init && git submodule update`
Dir.chdir('emacs.d/elisp/rinari') {
  puts `git submodule init && git submodule update`
}

pwd = File.expand_path(File.dirname(__FILE__))
dot_installs = [
                'zsh.d',
                'zshrc',
                'zshenv',
                'emacs.d',
                'screenrc',
                'irbrc',
                'tmux.conf',
               ]
local_installs = [
                  'bin',
                 ]

dot_installs.each do |f|
  target = File.expand_path("~/.#{f}")
  if File.exists?(target)
    puts "#{target} already exist. skipped"
    next
  end
  cmd = "ln -s #{pwd}/#{f} ~/.#{f}"
  puts cmd
  system(cmd)
end

local_installs.each do |dir|
  target_dir = File.expand_path("~/local/#{dir}")
  FileUtils.mkdir_p(target_dir) unless File.exists?(target_dir)
  Dir.glob("#{dir}/*") {|path|
    f = File.basename(path)
    target = "#{target_dir}/#{f}"
    if File.exists?(target)
      puts "#{target} already exist. skippd"
      next
    end
    cmd = "ln -s #{pwd}/#{dir}/#{f} #{target}"
    puts cmd
    system(cmd)
  }
end

# local_installs.each do |f|
#   target_dir = File.expand_path("~/local/#{f}")
#   Dir.mkdir(target_dir) unless File.exists?(target_dir)
#   target = "#{target_dir}/#{f}"
#   if File.exists?(target)
#     puts "#{target} already exist. skippd"
#     next
#   end
#   cmd = "ln -s #{pwd}/#{f} #{target}"
#   puts cmd
#   system(cmd)
# end
