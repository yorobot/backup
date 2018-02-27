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
  r.stats.committed.jd <=> l.stats.committed.jd
end


## pp entries


buf << "committed / pushed / updated / created\n\n"


today = Date.today

entries.each_with_index do |repo,i|

  days_ago = today.jd - repo.stats.committed.jd

  diff1 = repo.stats.committed.jd - repo.stats.pushed.jd
  diff2 = repo.stats.committed.jd - repo.stats.updated.jd
  diff3 = repo.stats.pushed.jd    - repo.stats.updated.jd

  buf <<  "- (#{days_ago}d) **#{repo.full_name}** ★#{repo.stats.stars} - "
  buf <<  "#{repo.stats.committed} "
  buf <<  "("
  buf <<  (diff1==0 ? '=' : "#{diff1}d")
  buf <<  "/"
  buf <<  (diff2==0 ? '=' : "#{diff2}d")
  buf <<  ")"
  buf <<  " / "
  buf <<  "#{repo.stats.pushed} "
  buf <<  "("
  buf <<  (diff3==0 ? '=' : "#{diff3}d")
  buf <<  ")"
  buf <<  " / "
  buf <<  "#{repo.stats.updated} / "
  buf <<  "#{repo.stats.created} - "
  buf <<  "‹#{repo.stats.last_commit_message}›"
  buf <<  " (#{repo.stats.size} kb)"
  buf <<  "\n"
end


puts buf

File.open( "./UPDATES.md", "w" ) do |f|
  f.write buf
end
