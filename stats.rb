# encoding: utf-8

require_relative 'lib/stats'


## create a (summary report)

##  add stars, last_updates, etc.
##  org description etc??


stats = GitHubStats.from_file( "./repos.yml" )

## print stats

puts "  #{stats.orgs.size} orgs, #{stats.repos.size} repos"


## note: orgs is orgs+users e.g. geraldb,skriptbot, etc
buf = ''
buf << "# #{stats.orgs.size} orgs, #{stats.repos.size} repos\n"
buf << "\n"



entries = stats.repos.dup   ## duplicate array (will resort etc.)


entries = entries.sort do |l,r|
  ## note: use reverse sort (right,left) - e.g. most stars first
  r.stats.stars <=> l.stats.stars
end

## pp entries


entries.each_with_index do |repo,i|
  buf << "#{i+1}. ★#{repo.stats.stars} **#{repo.full_name}** (#{repo.stats.size} kb)\n"
end


puts buf

File.open( "./STARS.md", "w" ) do |f|
  f.write buf
end
