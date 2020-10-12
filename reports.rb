## hack: use "local" hubba dev version for now
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba/lib' )
require 'hubba'


stats = Hubba.stats( './repos.yml' )

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
=end

report = Hubba::ReportTrafficReferrers.new( stats )
report.save( './REFERRERS.md' )

puts "Done."