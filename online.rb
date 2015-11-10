# encoding: utf-8

require './github'


def save_json( name, data )    ## data - hash or array
  File.open( "../cache/#{name}.json", "w" ) do |f|
    f.write JSON.pretty_generate( data )
  end
end

def save_yaml( name, data )
  File.open( "./#{name}.yml", "w" ) do |f|
    f.write data.to_yaml
  end
end



def save_repos
  gh = GitHub.new
  
  h = {}
  users = %w( gerald skriptbot )
  users.each do |user|
    res = gh.user_repos( user )
    save_json( "#{user}~repos", res.data )

    repos = res.names    
    h[ "#{user} (#{repos.size})" ] = repos
    save_yaml( "repos", h )
  end
end

save_repos


#  json = gh.user_orgs('geraldb')
#  
#  orgs = []
#  json.each do |org|     ## note: assume array gets returned
#    orgs << org['login']
#  end
end



## gh = GitHub.new

## save_json 'geraldb.json',       gh.user('geraldb')
## save_json 'geraldb.repos.json', gh.user_repos('geraldb')
## save_json 'geraldb.orgs.json',  gh.user_orgs('geraldb')

## save_json 'skriptbot.json',       gh.user('skriptbot')
## save_json 'skriptbot.repos.json', gh.user_repos('skriptbot')

## save_json 'wikiscript.repos.json', gh.org_repos('wikiscript').data
## save_json 'vienna-rb.repos.json', gh.org_repos('vienna-rb').data

## save_json 'wikiscript.json', gh.org('wikiscript')
## save_json 'vienna-rb.json', gh.org('vienna-rb')

## save_json 'planetjekyll.json',        gh.org('planetjekyll')
## save_json 'planetjekyll.repos.json',  gh.org_repos('planetjekyll').data


puts "Done."


