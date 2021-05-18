#!/usr/bin/env ruby

raise "Necessário informar um arquivo de configuração:\nFomato:\n\t./traveller input.csv" if ARGV[0].nil?
raise "Arquivo de configuração #{ARGV[0]} não encontrado!" unless File.exist?(ARGV[0])

ROOT_DIR = File.dirname(__FILE__)

require File.join(ROOT_DIR, './src/app.rb')

app = App.new(File.read(ARGV.pop))
app.run
