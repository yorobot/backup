# encoding: utf-8

require_relative 'lib/stats'


## create a (timeline report)

stats = GitHubStats.from_file( "./repos.yml" )

## print stats

puts "  #{stats.orgs.size} orgs, #{stats.repos.size} repos"


## note: orgs is orgs+users e.g. geraldb,skriptbot, etc
buf = ''
buf << "# #{stats.orgs.size} orgs, #{stats.repos.size} repos\n"
buf << "\n"


entries = stats.repos.dup   ## duplicate array (will resort etc.)


entries = entries.sort do |l,r|
  ## note: use reverse sort (right,left) - e.g. most stars first
  ## r[:stars] <=> l[:stars]

  ## sort by created_at (use julian days)
  r.created_at.to_date.jd <=> l.created_at.to_date.jd
end


## pp entries


last_year  = -1
last_month = -1

entries.each_with_index do |repo,i|
  year       = repo.created_at.year
  month      = repo.created_at.month

  if last_year != year
    buf << "\n## #{year}\n\n"
  end

  if last_month != month
    buf << "\n### #{month}\n\n"
  end


  last_year  = year
  last_month = month

  buf << "- #{repo.created_at.strftime('%Y-%m-%d')} ★#{repo.stats.stars} **#{repo.full_name}** (#{repo.stats.size} kb)\n"
end

puts buf


File.open( "./TIMELINE.md", "w" ) do |f|
  f.write buf
end
