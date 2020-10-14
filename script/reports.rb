## hack: use "local" hubba dev version for now
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba/lib' )
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba-reports/lib' )
require 'hubba/reports'


Hubba.config.data_dir = '../cache.github'


stats = Hubba.stats( './config/repos.yml' )

=begin
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


report = Hubba::ReportCatalog.new( stats )
report.save( './CATALOG.md' )


report = Hubba::ReportTrafficReferrers.new( stats )
report.save( './REFERRERS.md' )

report = Hubba::ReportSize.new( stats )
report.save( './SIZE.md' )
=end

report = Hubba::ReportTopics.new( stats )
report.save( './TOPICS.md' )


puts "Done."
