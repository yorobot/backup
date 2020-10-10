## hack: use "local" hubba dev version for now
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba/lib' )
require 'hubba'



gh = Hubba::GitHub.new

## res = gh.repo( 'bitsblocks/ethereum' )
## res = gh.repo( 'openfootball/italy' )
## pp res.data

puts
## res = gh.repo_languages( 'openfootball/italy' )
res = gh.repo_languages( 'openfootball/world' )
## res = gh.repo_languages( 'sportdb/sport.db' )
pp res.data
=begin
{}
{}
{"Ruby"=>1020599, "HTML"=>3219, "SCSS"=>508, "CSS"=>388}
=end

puts
## res = gh.repo_topics( 'openfootball/italy' )
res = gh.repo_topics( 'openfootball/world' )
## res = gh.repo_topics( 'sportdb/sport.db' )
pp res.data

=begin
{"names"=>
  ["opendata",
   "football",
   "seriea",
   "italia",
   "italy",
   "juve",
   "inter",
   "napoli",
   "roma",
   "sqlite"]}

{"names"=>[]}

{"names"=>["sport", "opendata", "football"]}
=end


puts "bye"