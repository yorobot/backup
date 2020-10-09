## hack: use "local" hubba dev version for now
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba/lib' )
require 'hubba'



report = Hubba::ReportSummary.new( './repos.yml' )
report.save( './SUMMARY.md' )

puts "Done."