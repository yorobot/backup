## hack: use "local" gitti/gitti-backup dev version for now
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/gitti/lib' )
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/gitti-backup/lib' )
require 'gitti/backup/base'




backup = Gitti::GitBackup.new( '/backup', daily: false )

backup.backup( Gitti::GitRepoSet.read( './config/repos.yml' ))


puts "bye"

