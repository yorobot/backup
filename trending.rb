# encoding: utf-8


###
## todo:
##   use calc per month !!!
##   per week is too optimistic (e.g. less than one star/week e.g. 0.6 or something)



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



def calc_diff( history )

  history_keys  = history.keys.sort.reverse
  if history_keys.size >= 2
    h0 = history[ history_keys[0] ]
    h1 = history[ history_keys[1] ]
    stars0 = h0['stargazers_count'] || 0
    stars1 = h1['stargazers_count'] || 0
    d0 = Date.strptime( history_keys[0], '%Y-%m-%d' )
    d1 = Date.strptime( history_keys[1], '%Y-%m-%d' )

    ## check for shortcut; stars count is 1
    if stars0 == 1
      diff = 0
    else
      stars_diff = stars0 - stars1
      days_diff  = d0.jd - d1.jd
      puts "diff stars-diff / days_diff = #{stars_diff} / #{days_diff} = #{stars_diff/days_diff}, #{(stars_diff*70/days_diff)}/week"
      diff = (stars_diff*70 / days_diff )    ## use stars/week (diff in 7 days)
    end
  else
    diff = 0
  end

  diff
end


def show_history( history )
  buf = ''
  last_date  = nil
  last_stars = nil

  history_keys  = history.keys.sort   ## note: start with oldest first
  history_keys.each do |key|
     h = history[ key ]
     stars = h['stargazers_count'] || 0
     date  = Date.strptime( key, '%Y-%m-%d' )

     line = "#{stars}"
     if last_date && last_stars
       stars_diff = stars   - last_stars
       days_diff  = date.jd - last_date.jd

       if stars_diff > 0 || stars_diff < 0
         if stars_diff > 0
           line << " (+#{stars_diff}"
         else
           line << " (#{stars_diff}"
         end
         line << " in #{days_diff}d) "
       else
         line << " (#{days_diff}d) "
       end

       buf.prepend( line )
     end
     last_date =  date
     last_stars = stars
  end
  buf
end # mehtod show_diff



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
      history:    stats.history,
      diff:       calc_diff( stats.history ),
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
  ## r[:created_at].to_date.jd <=> l[:created_at].to_date.jd

  res = r[:diff] <=> l[:diff]
  res = r[:stars] <=> l[:stars]  if res == 0
  res = r[:created_at].to_date.jd <=> l[:created_at].to_date.jd  if res == 0
  res
end


## pp entries


entries.each_with_index do |rec,i|
  if rec[:diff] == 0
    buf << "-  -/- "
  else
    buf << "- #{rec[:diff].to_f/10}/week "
  end

  buf <<  " ★#{rec[:stars]} **#{rec[:name]}** (#{rec[:size]} kb) - "
  buf <<  "#{show_history(rec[:history])} / #{rec[:history].inspect}\n"
end


File.open( "./TRENDING.md", "w" ) do |f|
  f.write buf
end
