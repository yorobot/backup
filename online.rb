## hack: use "local" hubba dev version for now
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba/lib' )
require 'hubba'

puts Hubba.banner
puts Hubba.root
puts Hubba.config.data_dir

##  todo/fix:
##  use/add gh.cache.put( )  or gh.cache.save()
##     instead of  save_json !!!



CACHE_DIR = './cache'
DATA_DIR  = './data'     # note: is just a subfolder for now inside this reop (thus, .) - stores stats/history (e.g. stars, last commit, size, etc.)



def save_json( path, data )    ## data - hash or array
  File.open( path, 'w:utf-8' ) do |f|
    f.write( JSON.pretty_generate( data ))
  end
end

def save_yaml( path, data )
  File.open( path, 'w:utf-8' ) do |f|
    f.write( data.to_yaml )
  end
end




def save_repos
  gh = Hubba::Github.new

  forks = []

  h = {}
  users = %w[geraldb yorobot]
  users.each do |user|
    res = gh.user_repos( user )
    save_json( "#{CACHE_DIR}/users~#{user}~repos.json", res.data )

    repos = []
    ####
    #  check for forked repos (auto-exclude personal by default)
    #   note: forked repos in orgs get NOT auto-excluded!!!
    res.data.each do |repo|
      fork = repo['fork']
      if fork
        print "FORK "
        forks << "#{repo['full_name']} (AUTO-EXCLUDED)"
      else
        print "     "
        repos << repo['name']
      end
      print repo['full_name']
      print "\n"
    end


    h[ "#{user} (#{repos.size})" ] = repos.sort
  end


  ## all repos from orgs
  user = 'geraldb'
  res = gh.user_orgs( user )
  save_json( "#{CACHE_DIR}/users~#{user}~orgs.json", res.data )


  logins = res.logins.each do |login|
    ## next if ['xxx'].include?( login )      ## add orgs here to skip

    res = gh.org_repos( login )
    save_json( "#{CACHE_DIR}/orgs~#{login}~repos.json", res.data )

    repos = []
    res.data.each do |repo|
      fork = repo['fork']
      if fork
        print "FORK "
        forks << repo['full_name']
        repos << repo['name']
      else
        print "     "
        repos << repo['name']
      end
      print repo['full_name']
      print "\n"
    end

    h[ "#{login} (#{repos.size})" ] = repos.sort
  end


  save_yaml( "./repos.yml", h )


  if forks.size > 0
    puts
    puts "#{forks.size} fork(s):"
    puts forks
  end
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

### todo - ask user (gets??) - if update repo stats (yes/no) might take a while (make it optional??)
## update_repo_stats()


puts "Done."
