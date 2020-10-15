#####
# sync github data in ../cache.github

require 'gitti'


## use  require helper
##      and Hubba.config.data_dir  - why? why not?

GitProject.open( '../cache.github' ) do |proj|
  proj.ff
  proj.changes   ## git status --short
end

