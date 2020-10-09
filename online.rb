## hack: use "local" hubba dev version for now
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba/lib' )
require 'hubba'

puts Hubba.banner
puts Hubba.root
puts Hubba.config.data_dir

##  todo/fix:
##  use/add gh.cache.put( )  or gh.cache.save()
##     instead of  save_json !!!


h = Hubba.reposet( 'geraldb', 'yorobot', cache: true )
pp h

save_yaml( "./repos.yml", h )


puts "Done."
