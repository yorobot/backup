## hack: use "local" hubba dev version for now
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba/lib' )
require 'hubba'



## create a (summary report)

## todo: use githubi with cache instead of yml source ??
##
##  add stars, last_updates, etc.
##  org description etc??


stats = Hubba.stats( './repos.yml' )

## print stats

puts "  #{stats.repos.size} repos @ #{stats.orgs.size} orgs"


## note: orgs is orgs+users e.g. geraldb, yorobot etc
buf = String.new('')
buf << "# #{stats.repos.size} repos @ #{stats.orgs.size} orgs\n"
buf << "\n"



stats.orgs.each do |org|
  name  = org[0]
  repos = org[1]
  buf << "### #{name} _(#{repos.size})_\n"
  buf << "\n"

  ### add stats for repos
  entries = []
  repos.each do |repo|
    entries << "**#{repo.name}** ★#{repo.stats.stars} (#{repo.stats.size} kb)"
  end

  buf << entries.join( ' · ' )   ## use interpunct? - was: • (bullet)
  buf << "\n"
  buf << "\n"
end


puts buf

File.open( "./SUMMARY.md", "w:utf-8" ) do |f|
  f.write buf
end

puts "bye"