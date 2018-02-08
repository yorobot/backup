# encoding: utf-8

require 'hubba'    ## used in "offline" mode (e.g. reads stats from ./data folder)


## create a (timeline report)


h = YAML.load_file( "./repos.yml" )
pp h


##
# note: vienna-rb org gets skipped, thus
#   orgs+users e.g. 43+2=45  --   -1 = 44(!)

org_count   = 0
repo_count  = 0

repos = h
repos.each do |key_with_counter,values|
  repo_count += values.size
  org_count  += 1
end

## print stats

puts "  #{org_count} orgs, #{repo_count} repos"


## note: orgs is orgs+users e.g. geraldb,skriptbot, etc
buf = ''
buf << "# #{org_count} orgs, #{repo_count} repos\n"
buf << "\n"



entries = []


repos.each do |key_with_counter,values|
  key = key_with_counter.sub( /\s+\([0-9]+\)/, '' )

  values.each do |value|
    full_name = "#{key}/#{value}"
    puts full_name
    stats = Hubba::Stats.new( full_name )
    stats.read( data_dir: './data' )

   ###
   #  date format:   2018-01-06T23:10:01Z

    rec = {
      name:       full_name,
      stars:      stats.stars,
      size:       stats.size,
      created_at: stats.created_at ? DateTime.strptime( stats.created_at, '%Y-%m-%dT%H:%M:%S') : nil,
      updated_at: stats.updated_at ? DateTime.strptime( stats.updated_at, '%Y-%m-%dT%H:%M:%S') : nil,
      pushed_at:  stats.pushed_at  ? DateTime.strptime( stats.pushed_at, '%Y-%m-%dT%H:%M:%S')  : nil
    }

    entries << rec
  end
end


puts buf


entries = entries.sort do |l,r|
  ## note: use reverse sort (right,left) - e.g. most stars first
  ## r[:stars] <=> l[:stars]

  ## sort by created_at (use julian days)
  r[:created_at].to_date.jd <=> l[:created_at].to_date.jd
end


pp entries


last_year  = -1
last_month = -1

entries.each_with_index do |rec,i|
  created_at = rec[:created_at]
  year       = created_at.year
  month      = created_at.month

  if last_year != year
    buf << "\n## #{year}\n\n"
  end

  if last_month != month
    buf << "\n### #{month}\n\n"
  end


  last_year  = year
  last_month = month

  buf << "#{created_at.strftime('%Y-%m-%d')} ★#{rec[:stars]} **#{rec[:name]}** (#{rec[:size]} kb)\n"
end


File.open( "./TIMELINE.md", "w" ) do |f|
  f.write buf
end
