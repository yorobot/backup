# encoding: utf-8

require 'yaml'
require 'pp'


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


repos.each do |key_with_counter,values|
  key = key_with_counter.sub( /\s+\([0-9]+\)/, '' )
  buf << "### #{key} _(#{values.size})_\n"
  buf << "\n"
  buf << values.join( ' • ' ) 
  buf << "\n"
  buf << "\n"
end


puts buf

File.open( "./SUMMARY.md", "w" ) do |f|
  f.write buf
end
