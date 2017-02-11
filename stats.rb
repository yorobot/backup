# encoding: utf-8

require 'yaml'
require 'pp'

require_relative './lib/stats'


## create a (summary report)

## todo: use githubi with cache instead of yml source ??
##
##  add stars, last_updates, etc.
##  org description etc??



h = YAML.load_file( "./repos.yml" )
pp h


##
# note: vienna-rb org gets skipped, thus
#   orgs+users e.g. 43+2=45  --   -1 = 44(!)

org_count   = 0
repo_count  = 0

repos = h
repos.each do |key_with_counter,values|
  repo_count += values.size
  org_count  += 1
end

## print stats

puts "  #{org_count} orgs, #{repo_count} repos"


## note: orgs is orgs+users e.g. geraldb,skriptbot, etc
buf = ''
buf << "# #{org_count} orgs, #{repo_count} repos\n"
buf << "\n"


## todo: add to githubrepostats class ???
def starcount( stats )
   stars1 = 0

   history = stats.data['history']
   if history
        history_keys  = stats.data['history'].keys.sort.reverse
        ## todo/fix: for now assumes one entry per week
        ##    simple case [0] and [1] for a week later
        ##   check actual date - why? why not?
        stats_t1 = history_keys[0] ? history[ history_keys[0] ] : nil
        if stats_t1
          stars1 = stats_t1['stargazers_count']
          stars1 = stars1.to_i
        end
   end
   stars1
end  # method startcounts



gh = Hubba::Github.new( cache_dir: '../cache' )


data = []


repos.each do |key_with_counter,values|
  key = key_with_counter.sub( /\s+\([0-9]+\)/, '' )

  values.each do |value|
    full_name = "#{key}/#{value}"
    puts full_name
    stats = GithubRepoStats.new( full_name )
    stats.read( data_dir: './data' )

    rec = {
      name: full_name,
      stars: starcount( stats )
    }

    data << rec


##    stats.fetch( gh )
##    stats.write( data_dir: './data' )
  end
end


puts buf


data = data.sort do |l,r|
  ## note: use reverse sort (right,left) - e.g. most stars first
  r[:stars] <=> l[:stars]
end

pp data


data.each_with_index do |rec,i|
  buf << "#{i+1}. ★#{rec[:stars]} **#{rec[:name]}**\n"
end


File.open( "./STARS.md", "w" ) do |f|
  f.write buf
end
