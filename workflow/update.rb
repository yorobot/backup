require "hubba"

Hubba.config.data_dir = "./cache.github"



h = Hubba.reposet( "geraldb" )   ## note: do NOT include yorobot for now
pp h

Hubba.update_stats( h )
Hubba.update_traffic( h )

puts "Done."
