# encoding: utf-8

require 'githubi'


CACHE_DIR = '../cache'

def save_json( name, data )    ## data - hash or array
  File.open( "#{CACHE_DIR}/#{name}.json", "w" ) do |f|
    f.write JSON.pretty_generate( data )
  end
end

def save_yaml( name, data )
  File.open( "./#{name}.yml", "w" ) do |f|
    f.write data.to_yaml
  end
end



def save_repos
  gh = Githubi::Github.new( cache_dir: CACHE_DIR )
  
  h = {}
  users = %w(geraldb skriptbot)
  users.each do |user|
    res = gh.user_repos( user )
    save_json( "users~#{user}~repos", res.data )

    repos = res.names    
    h[ "#{user} (#{repos.size})" ] = repos
  end

  ## all repos from orgs
  user = 'geraldb'
  res = gh.user_orgs( user )
  save_json( "users~#{user}~orgs", res.data )

  logins = res.logins.each do |login|
    next if ['vienna-rb'].include?( login )      ## skip vienna-rb for now
    res = gh.org_repos( login )
    save_json( "orgs~#{login}~repos", res.data )

    repos = res.names    
    h[ "#{login} (#{repos.size})" ] = repos
  end  

  save_yaml( "repos", h )
end  ## method save_repos


def save_orgs
  gh = Githubi::Github.new( cache_dir: CACHE_DIR )

  h = {}
  user = 'geraldb'
  res = gh.user_orgs( user )
  save_json( "users~#{user}~orgs", res.data )
  orgs = res.logins

  h[ "#{user} (#{orgs.size})" ] = orgs 

  save_yaml( "orgs", h )
end  ## method save_repos

## save_repos()
save_orgs()


# gh = Githubi::Github.new( cache_dir: CACHE_DIR )
# save_json 'orgs~openfootball~repos', gh.org_repos('openfootball').data
# save_json 'orgs~openbeer~repos',     gh.org_repos('openbeer').data

## save_json 'geraldb',       gh.user('geraldb').data
## save_json 'geraldb.repos', gh.user_repos('geraldb').data
## save_json 'geraldb.orgs',  gh.user_orgs('geraldb').data

## save_json 'skriptbot',       gh.user('skriptbot').data
## save_json 'skriptbot.repos', gh.user_repos('skriptbot').data

## save_json 'wikiscript.repos', gh.org_repos('wikiscript').data
## save_json 'vienna-rb.repos', gh.org_repos('vienna-rb').data

## save_json 'wikiscript', gh.org('wikiscript').data
## save_json 'vienna-rb', gh.org('vienna-rb').data

## save_json 'planetjekyll',        gh.org('planetjekyll').data
## save_json 'planetjekyll.repos',  gh.org_repos('planetjekyll').data


puts "Done."

