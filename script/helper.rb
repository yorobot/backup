## hack: use "local" hubba dev version for now
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba/lib' )
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba-reports/lib' )
require 'hubba/reports'


Hubba.config.data_dir = '../cache.github'

