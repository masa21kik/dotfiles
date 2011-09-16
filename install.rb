#!/usr/bin/env ruby
# -*- mode: ruby; coding: utf-8 -*-

pwd = File.expand_path(File.dirname(__FILE__))
install_files = [
                 'zsh.d',
                 'zshrc',
                 'zshenv',
                 'emacs.d',
                 'screenrc',
                 'irbrc',
                ]

install_files.each do |f|
  target = File.expand_path("~/.#{f}")
  if File.exists?(target)
    puts "File #{target} already exist. skipped"
    next
  end
  cmd = "ln -s #{pwd}/#{f} ~/.#{f}"
  puts cmd
  system(cmd)
end
