require_relative 'helper'



all = YAML.load_file( './config/repos.yml' )
pp all

####
## remove yorobot user/org entry  (is really just a sandbox / semi-private)
##  - add some more (e.g. sandbox?)
##  note: orgs may include counter e.g. yorobot (18) or such
all.delete_if {|org,names| org.start_with?( 'yorobot' ) }



stats = Hubba.stats( all )

report = Hubba::ReportCatalog.new( stats )
report.save( './CATALOG.md' )

report = Hubba::ReportSummary.new( stats )
report.save( './SUMMARY.md' )

report = Hubba::ReportStars.new( stats )
report.save( './STARS.md' )

report = Hubba::ReportTimeline.new( stats )
report.save( './TIMELINE.md' )

report = Hubba::ReportTrending.new( stats )
report.save( './TRENDING.md' )

report = Hubba::ReportUpdates.new( stats )
report.save( './UPDATES.md' )


report = Hubba::ReportTraffic.new( stats )
report.save( './TRAFFIC.md' )

report = Hubba::ReportTrafficPages.new( stats )
report.save( './PAGES.md' )

report = Hubba::ReportTrafficReferrers.new( stats )
report.save( './REFERRERS.md' )


report = Hubba::ReportSize.new( stats )
report.save( './SIZE.md' )

report = Hubba::ReportTopics.new( stats )
report.save( './TOPICS.md' )


puts "Done."
