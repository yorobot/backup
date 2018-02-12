# encoding: utf-8

require_relative 'lib/stats'


## create a (summary report)

## todo: use githubi with cache instead of yml source ??
##
##  add stars, last_updates, etc.
##  org description etc??


stats = GitHubStats.from_file( "./repos.yml" )

## print stats

puts "  #{stats.orgs.size} orgs, #{stats.repos.size} repos"


## note: orgs is orgs+users e.g. geraldb,skriptbot, etc
buf = ''
buf << "# #{stats.orgs.size} orgs, #{stats.repos.size} repos\n"
buf << "\n"


stats.orgs.each do |values|
  name  = values[0]
  repos = values[1]
  buf << "### #{name} _(#{repos.size})_\n"
  buf << "\n"

  ### add stats for repos
  entries = []
  repos.each do |repo|
    entries << "**#{repo.name}** ★#{repo.stats.stars} (#{repo.stats.size} kb)"
  end

  buf << entries.join( ' • ' )
  buf << "\n"
  buf << "\n"
end


puts buf

File.open( "./SUMMARY.md", "w" ) do |f|
  f.write buf
end
