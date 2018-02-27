# encoding: utf-8


###
## todo:
##   use calc per month (days: 30)
##   per week is too optimistic (e.g. less than one star/week e.g. 0.6 or something)



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
  ## r[:created_at].to_date.jd <=> l[:created_at].to_date.jd

  res = r.diff <=> l.diff
  res = r.stats.stars <=> l.stats.stars  if res == 0
  res = r.stats.created.jd <=> l.stats.created.jd  if res == 0
  res
end


## pp entries


entries.each_with_index do |repo,i|
  if repo.diff == 0
    buf << "-  -/- "
  else
    buf << "- #{repo.diff}/month "
  end

  buf <<  " ★#{repo.stats.stars} **#{repo.full_name}** (#{repo.stats.size} kb) - "
  buf <<  "#{repo.stats.history_str}\n"
end


puts buf

File.open( "./TRENDING.md", "w" ) do |f|
  f.write buf
end
