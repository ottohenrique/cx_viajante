#!/usr/bin/env ruby

raise "Missing routes config file" if ARGV[0].nil?
raise "Route config file not found" unless File.exist?(ARGV[0])

ROOT_DIR = File.dirname(__FILE__)

require File.join(ROOT_DIR, './src/app.rb')

app = App.new(File.read(ARGV[0]))
app.run
