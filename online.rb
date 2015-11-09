# encoding: utf-8

require './github'


def save_json( name, data )    ## data - hash or array
  File.open( "./cache/#{name}", "w" ) do |f|
    f.write JSON.pretty_generate( data )
  end
end


gh = GitHub.new

save_json 'geraldb.json',       gh.user('geraldb')
save_json 'geraldb.repos.json', gh.user_repos('geraldb')
save_json 'geraldb.orgs.json',  gh.user_orgs('geraldb')

save_json 'skriptbot.json',       gh.user('skriptbot')
save_json 'skriptbot.repos.json', gh.user_repos('skriptbot')

## gh.org('planetjekyll')


puts "Done."


