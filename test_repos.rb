# encoding: utf-8

require 'yaml'
require 'pp'


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
