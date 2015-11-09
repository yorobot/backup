# encoding: utf-8

require './github'


gh = GitHub.new
gh.offline!   # switch to offline (mode)

pp gh.user('geraldb')
pp gh.user_repos('geraldb')
pp gh.user_orgs('geraldb')



logins = gh.user_orgs('geraldb').logins
## pp logins
puts "  #{logins.size} orgs"

h = { "orgs (#{logins.size})" => logins }

puts h.to_yaml


h    = {}
orgs = %w(planetjekyll wikiscript)

orgs.each do |org|
  names = gh.org_repos( org ).names
  h[ "#{org} (#{names.size})" ] = names
end

puts h.to_yaml


puts "Done."

