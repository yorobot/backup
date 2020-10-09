require 'pp'
require 'date'     ##  Date.today


backup_dir = "~/backup/#{Date.today.strftime('%Y-%m-%d')}"   ## e.g. 2015-07-21
backup_dir = File.expand_path( backup_dir )
pp backup_dir

