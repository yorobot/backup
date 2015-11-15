# encoding: utf-8

require 'githubi'


##  todo/fix:
##  use/add gh.cache.put( )  or gh.cache.save()
##     instead of  save_json !!!


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

save_repos()
save_orgs()


puts "Done."

