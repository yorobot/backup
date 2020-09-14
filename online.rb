# encoding: utf-8

## hack: use "local" hubba dev version for now
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/hubba/lib' )

require 'hubba'


##  todo/fix:
##  use/add gh.cache.put( )  or gh.cache.save()
##     instead of  save_json !!!


CACHE_DIR = '../cache'   # note: is its own repo (thus, ..)
DATA_DIR  = './data'     # note: is just a subfolder for now inside this reop (thus, .) - stores stats/history (e.g. stars, last commit, size, etc.)


def save_json( name, data )    ## data - hash or array
  File.open( "#{CACHE_DIR}/#{name}.json", 'w:utf-8' ) do |f|
    f.write JSON.pretty_generate( data )
  end
end

def save_yaml( name, data )
  File.open( "./#{name}.yml", 'w:utf-8' ) do |f|
    f.write data.to_yaml
  end
end



def save_repos
  gh = Hubba::Github.new( cache_dir: CACHE_DIR )

  h = {}
  users = %w(geraldb yorobot)
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
    next if ['vienna-rb', 'RubyHabits', 'rugl-at', 'jekyll-octopod'].include?( login )      ## skip vienna-rb for now
    res = gh.org_repos( login )
    save_json( "orgs~#{login}~repos", res.data )

    repos = res.names
    h[ "#{login} (#{repos.size})" ] = repos
  end

  save_yaml( "repos", h )
end  ## method save_repos


def save_orgs
  gh = Hubba::Github.new( cache_dir: CACHE_DIR )

  h = {}
  user = 'geraldb'
  res = gh.user_orgs( user )
  save_json( "users~#{user}~orgs", res.data )
  orgs = res.logins

  h[ "#{user} (#{orgs.size})" ] = orgs

  save_yaml( "orgs", h )
end  ## method save_repos


####
## up stats for all repos (in )
##
##  todo/check: use gitti repolist (exits?) or something -reuse, reuse, reuse!!!!
##

def update_repo_stats
  h = YAML.load_file( "./repos.yml" )
  pp h

  org_count   = 0
  repo_count  = 0
  count       = 0

  repos = h
  repos.each do |key_with_counter,values|
    repo_count += values.size
    org_count  += 1
  end

  ## print stats
  puts "  #{org_count} orgs, #{repo_count} repos"

  gh = Hubba::Github.new( cache_dir: CACHE_DIR )

  repos.each do |key_with_counter,values|
    key = key_with_counter.sub( /\s+\([0-9]+\)/, '' )

    values.each do |value|
      full_name = "#{key}/#{value}"
      puts "  fetching stats #{count+1}/#{repo_count} - >#{full_name}<..."
      stats = Hubba::Stats.new( full_name )
      stats.read( data_dir: DATA_DIR )
      stats.fetch( gh )
      stats.write( data_dir: DATA_DIR )
      count += 1
    end
  end
end   # method  update_repo_stats


save_repos()
save_orgs()

### todo - ask user (gets??) - if update repo stats (yes/no) might take a while (make it optional??)

update_repo_stats()


puts "Done."
