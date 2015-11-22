# encoding: utf-8

require 'gitti'
require 'gitti/backup'

include Gitti    ## lets you use Git, GitError, etc.


backup = GitBackup.new( '~/backup' )

repos = GitRepoSet.from_file( './repos.yml' )
backup.backup( repos )

