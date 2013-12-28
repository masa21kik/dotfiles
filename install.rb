#!/usr/bin/env ruby
# -*- mode: ruby; coding: utf-8 -*-
require 'fileutils'

def exec_cmd(cmd)
  puts cmd
  system(cmd)
end

pwd = File.expand_path(File.dirname(__FILE__))
dot_installs = %w(zsh.d zshrc zshenv emacs.d
                screenrc irbrc tmux.conf)
local_installs = %w(bin)

dot_installs.each do |f|
  target = File.expand_path("~/.#{f}")
  if File.exists?(target)
    puts "#{target} already exist. skipped"
    next
  end
  exec_cmd("ln -s #{pwd}/#{f} ~/.#{f}")
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
    exec_cmd("ln -s #{pwd}/#{dir}/#{f} #{target}")
  }
end
