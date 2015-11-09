# encoding: utf-8

require './github'


gh = GitHub.new
gh.offline!   # switch to offline (mode)

pp gh.user('geraldb')
pp gh.user_repos('geraldb')
pp gh.user_orgs('geraldb')

puts "Done."

