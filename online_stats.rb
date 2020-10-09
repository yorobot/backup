## hack: use "local" hubba dev version for now
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba/lib' )
require 'hubba'

puts Hubba.banner
puts Hubba.root
puts Hubba.config.data_dir


### update stats records for all repos (in ./repos.yml)

####
## up stats for all repos (in )
##
##  todo/check: use gitti repolist (exits?) or something -reuse, reuse, reuse!!!!
##

h = YAML.load_file( './repos.yml' )
pp h

Hubba.update_stats( h )


puts "Done."
