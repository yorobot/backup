# encoding: utf-8

require_relative '../lib/stats'


themes = [
  'henrythemes/jekyll-starter-theme',
  'poole/hyde',
  'jekyll/minima'
]

gh = Hubba::Github.new( cache_dir: '../cache' )

themes.each do |theme|
  stats = GithubRepoStats.new( theme )
  stats.read( data_dir: './data' )
  stats.fetch( gh )
  stats.write( data_dir: './data' )
end
