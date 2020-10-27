

## repo (cache) for github analytics data
##   see https://github.com/yorobot/cache.github
##   use
##   - @yorobot/cache.github  or
##   - cache.github@yorobot
CACHE_REPO = "@yorobot/cache.github"


step :clone do
  Mono.clone( CACHE_REPO )
end


step :update do
  Hubba.config.data_dir = Mono.real_path( CACHE_REPO )

  username = "geraldb"
  h = Hubba.reposet( username )   ## note: do NOT include yorobot for now
  pp h

  Hubba.update_stats( h )
  Hubba.update_traffic( h )
  puts "Done."
end


step :push do
  msg = "auto-update week #{Date.today.cweek}"

  Mono.open( CACHE_REPO ) do |proj|
    if proj.changes?
      proj.add( "." )
      proj.commit( msg )
      proj.push
    end
  end
end
