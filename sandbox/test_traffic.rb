## hack: use "local" hubba dev version for now
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba/lib' )
require 'hubba'


gh = Hubba::GitHub.new


res = gh.repo_traffic_views( 'openfootball/england' )
pp res

# res = gh.repo_traffic_clones( 'openfootball/england' )
# pp res

## note: traffic_clones requires push access!!!!
## !! HTTP ERROR: 403 Forbidden:
## #<Net::HTTPForbidden 403 Forbidden readbody=true>

=begin
 {"count"=>51,
   "uniques"=>17,
   "clones"=>
    [{"timestamp"=>"2020-09-26T00:00:00Z", "count"=>1, "uniques"=>1},
     {"timestamp"=>"2020-09-27T00:00:00Z", "count"=>2, "uniques"=>1},
     {"timestamp"=>"2020-09-28T00:00:00Z", "count"=>2, "uniques"=>1},
     {"timestamp"=>"2020-09-29T00:00:00Z", "count"=>6, "uniques"=>3},
     {"timestamp"=>"2020-09-30T00:00:00Z", "count"=>3, "uniques"=>2},
     {"timestamp"=>"2020-10-01T00:00:00Z", "count"=>9, "uniques"=>8},
     {"timestamp"=>"2020-10-02T00:00:00Z", "count"=>2, "uniques"=>1},
     {"timestamp"=>"2020-10-03T00:00:00Z", "count"=>3, "uniques"=>2},
     {"timestamp"=>"2020-10-04T00:00:00Z", "count"=>3, "uniques"=>2},
     {"timestamp"=>"2020-10-05T00:00:00Z", "count"=>3, "uniques"=>2},
     {"timestamp"=>"2020-10-06T00:00:00Z", "count"=>4, "uniques"=>1},
     {"timestamp"=>"2020-10-07T00:00:00Z", "count"=>4, "uniques"=>1},
     {"timestamp"=>"2020-10-08T00:00:00Z", "count"=>3, "uniques"=>2},
     {"timestamp"=>"2020-10-09T00:00:00Z", "count"=>4, "uniques"=>3},
     {"timestamp"=>"2020-10-10T00:00:00Z", "count"=>2, "uniques"=>1}]}
=end


# res = gh.repo_traffic_popular_paths( 'openfootball/england' )
# res = gh.repo_traffic_popular_paths( 'rubycoco/git' )
# pp res

=begin
 [{"path"=>"/openfootball/england",
    "title"=>
     "openfootball/england: Free open public domain football data for England (and ...",
    "count"=>394,
    "uniques"=>227},
   {"path"=>"/openfootball/england/tree/master/2020-21",
    "title"=>
     "england/2020-21 at master \u00B7 openfootball/england \u00B7 GitHub",
    "count"=>196,
    "uniques"=>116},
   {"path"=>"/openfootball/england/blob/master/2020-21/1-premierleague.txt",
    "title"=>
     "england/1-premierleague.txt at master \u00B7 openfootball/england \u00B7 GitHub",
    "count"=>161,
    "uniques"=>97},
   {"path"=>"/openfootball/england/tree/master/2019-20",
    "title"=>
     "england/2019-20 at master \u00B7 openfootball/england \u00B7 GitHub",
    "count"=>70,
    "uniques"=>57},
   {"path"=>"/openfootball/england/blob/master/2019-20/1-premierleague.txt",
    "title"=>
     "england/1-premierleague.txt at master \u00B7 openfootball/england \u00B7 GitHub",
    "count"=>48,
    "uniques"=>41},
   {"path"=>"/openfootball/england/tree/master/clubs",
    "title"=>
     "england/clubs at master \u00B7 openfootball/england \u00B7 GitHub",
    "count"=>34,
    "uniques"=>27},
   {"path"=>"/openfootball/england/pulls",
    "title"=>"Pull requests \u00B7 openfootball/england \u00B7 GitHub",
    "count"=>27,
    "uniques"=>8},
   {"path"=>"/openfootball/england/issues",
    "title"=>"Issues \u00B7 openfootball/england \u00B7 GitHub",
    "count"=>21,
    "uniques"=>8},
   {"path"=>"/openfootball/england/tree/master/2000-01",
    "title"=>
     "england/2000-01 at master \u00B7 openfootball/england \u00B7 GitHub",
    "count"=>18,
    "uniques"=>15},
   {"path"=>"/openfootball/england/tree/master/clubs/1-names",
    "title"=>
     "england/clubs/1-names at master \u00B7 openfootball/england \u00B7 GitHub",
    "count"=>17,
    "uniques"=>17}]

[{"path"=>"/rubycoco/git",
    "title"=>"rubycoco/git: git command line tools, libraries & scripts",
    "count"=>41,
    "uniques"=>2},
   {"path"=>"/rubycoco/gitti",
    "title"=>
     "rubycoco/gitti: gitti gem - (yet) another (lite) git command line helper / wr...",
    "count"=>10,
    "uniques"=>3},
   {"path"=>"/rubycoco/git/tree/master/hubba",
    "title"=>"git/hubba at master \u00B7 rubycoco/git",
    "count"=>10,
    "uniques"=>2},
   {"path"=>"/rubycoco/git/commits/master",
    "title"=>"Commits \u00B7 rubycoco/git",
    "count"=>5,
    "uniques"=>2},
   {"path"=>"/rubycoco/gitti/tree/master/gitti",
    "title"=>"gitti/gitti at master \u00B7 rubycoco/gitti \u00B7 GitHub",
    "count"=>3,
    "uniques"=>3},
   {"path"=>"/rubycoco/gitti/commits/master",
    "title"=>"Commits \u00B7 rubycoco/gitti",
    "count"=>3,
    "uniques"=>1},
   {"path"=>"/rubycoco/git/tree/master/monos",
    "title"=>"git/monos at master \u00B7 rubycoco/git",
    "count"=>3,
    "uniques"=>1},
   {"path"=>"/rubycoco/git/tree/master/gitti",
    "title"=>"git/gitti at master \u00B7 rubycoco/git",
    "count"=>2,
    "uniques"=>2},
   {"path"=>"/rubycoco/git/tree/master/gitti-backup",
    "title"=>"git/gitti-backup at master \u00B7 rubycoco/git",
    "count"=>2,
    "uniques"=>2},
   {"path"=>"/rubycoco/git/blob/master/README.md",
    "title"=>"git/README.md at master \u00B7 rubycoco/git",
    "count"=>2,
    "uniques"=>1}]
=end


# res = gh.repo_traffic_popular_referrers( 'openfootball/england' )
# pp res
res = gh.repo_traffic_popular_referrers( 'rubycoco/git' )
pp res

=begin
 [{"referrer"=>"github.com", "count"=>327, "uniques"=>198},
   {"referrer"=>"openfootball.github.io", "count"=>71, "uniques"=>54},
   {"referrer"=>"Google", "count"=>5, "uniques"=>5},
   {"referrer"=>"reddit.com", "count"=>4, "uniques"=>4}]

[{"referrer"=>"github.com", "count"=>36, "uniques"=>3},
   {"referrer"=>"rubygems.org", "count"=>2, "uniques"=>1},
   {"referrer"=>"rubyflow.com", "count"=>1, "uniques"=>1}]
=end
