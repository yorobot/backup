#####
# sync github data in ../cache.github

require 'gitti'


GitProject.open( '../cache.github' ) do |proj|
  proj.ff
  proj.changes   ## git status --short
end

