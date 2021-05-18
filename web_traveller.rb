#!/usr/bin/env ruby

raise "Necessário informar um arquivo de configuração:\nFomato:\n\t./traveller input.csv" if ARGV[0].nil?
raise "Arquivo de configuração #{ARGV[0]} não encontrado!" unless File.exist?(ARGV[0])

ROOT_DIR = File.dirname(__FILE__)
NODES_FILE=ARGV.pop

require 'webrick'

require File.join(ROOT_DIR, './src/app.rb')


server = WEBrick::HTTPServer.new :Port => (ENV["PORT"] || 8000), :DocumentRoot => './README.md'

server.mount_proc "/routes" do |req, res|
  from = req.query["from"]
  to = req.query["to"]

  app = App.new(File.read(NODES_FILE))
  
  res.content_type="text/plain"
  res.body = app.cheapest_route(from, to) + "\n"
end

server.mount_proc "/route" do |req, res|
  if req.request_method == "POST"
    open(NODES_FILE, 'a') do |f|
      f << req.body.chomp + "\n"
    end
  end

  res.status = 201
end

trap 'INT' do server.shutdown end

server.start