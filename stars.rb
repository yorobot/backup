## hack: use "local" hubba dev version for now
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba/lib' )
require 'hubba'


## create a (summary report)

##  add stars, last_updates, etc.
##  org description etc??

report = Hubba::ReportStars.new( './repos.yml' )
report.save( './STARS.md' )

puts "Done."