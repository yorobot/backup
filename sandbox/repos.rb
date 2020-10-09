require 'pp'
require 'yaml'


h = YAML.load_file( "./repos.yml" )
pp h


org_count   = 0
repo_count  = 0

repos = h
repos.each do |org_with_counter,names|
  repo_count += names.size
  org_count  += 1
end

## print stats

puts "  #{repo_count} repos @ #{org_count} orgs"
