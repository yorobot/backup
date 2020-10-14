###
#  split repos.yml into subsets / topics
#  e.g. - football
#       - awesome
#       - blockchain
#       - ...??

require 'pp'
require 'yaml'


all = YAML.load_file( "./config/repos.yml" )
pp all


###
# football
#   incl.  orgs:
#    - openfootball
#    - footballcsv
h = {}
all.each do |org_with_counter,names|
  if org_with_counter.start_with?( 'openfootball') ||
     org_with_counter.start_with?( 'footballcsv')  ||
     org_with_counter.start_with?( 'rsssf' )
      h[org_with_counter] = names
  end
end

File.open( './config/football.yml', 'w' ) { |f| f.write( h.to_yaml ) }


###
# awesome
#   incl.  orgs with awesome repos
h = {}
all.each do |org_with_counter,names|
  awesomeness = names.select {|name| name.index( 'awesome' )}
  if awesomeness.size > 0
    ## update counter - why? why not?
    org_with_counter = org_with_counter.sub( /\([0-9]+\)/, '' ).strip
    org_with_counter = "#{org_with_counter} (#{awesomeness.size})"
    h[org_with_counter] = awesomeness
  end
end

File.open( './config/awesome.yml', 'w' ) { |f| f.write( h.to_yaml ) }


###
# blockchain
#   incl.  orgs:
h = {}
all.each do |org_with_counter,names|
  if org_with_counter.start_with?( 'bitsblocks') ||
     org_with_counter.start_with?( 'bitshilling') ||
     org_with_counter.start_with?( 'cryptocopycats' ) ||
     org_with_counter.start_with?( 'openblockchains' ) ||
     org_with_counter.start_with?( 's6ruby' ) ||
     org_with_counter.start_with?( 'viennacrypto' )
      h[org_with_counter] = names
  end
end

File.open( './config/blockchain.yml', 'w' ) { |f| f.write( h.to_yaml ) }



## hack: use "local" hubba dev version for now
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba/lib' )
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba-reports/lib' )
require 'hubba/reports'


Hubba.config.data_dir = '../cache.github'


stats = Hubba.stats( './config/repos.yml' )


topics = ['football',
          'awesome',
          'blockchain']

topics.each do |topic|
  ## create some reports
  stats = Hubba.stats( "./config/#{topic}.yml" )

  report = Hubba::ReportSummary.new( stats )
  report.save( "./topics/#{topic}/SUMMARY.md" )

  report = Hubba::ReportStars.new( stats )
  report.save( "./topics/#{topic}/STARS.md" )

  report = Hubba::ReportTrending.new( stats )
  report.save( "./topics/#{topic}/TRENDING.md" )

  report = Hubba::ReportUpdates.new( stats )
  report.save( "./topics/#{topic}/UPDATES.md" )


  report = Hubba::ReportTraffic.new( stats )
  report.save( "./topics/#{topic}/TRAFFIC.md" )

  report = Hubba::ReportTrafficPages.new( stats )
  report.save( "./topics/#{topic}/PAGES.md" )


  report = Hubba::ReportCatalog.new( stats )
  report.save( "./topics/#{topic}/CATALOG.md" )


  report = Hubba::ReportTrafficReferrers.new( stats )
  report.save( "./topics/#{topic}/REFERRERS.md" )

  report = Hubba::ReportSize.new( stats )
  report.save( "./topics/#{topic}/SIZE.md" )

  report = Hubba::ReportTopics.new( stats )
  report.save( "./topics/#{topic}/TOPICS.md" )
end
