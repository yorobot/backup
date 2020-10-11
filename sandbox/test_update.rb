## hack: use "local" hubba dev version for now
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba/lib' )
require 'hubba'


h = {
 # 'rubycoco'      => ['git'],
 'openfootball'  => # ['england', 'austria'],
                      ['football.json', 'world-cup.json'],
}

# Hubba.update_stats( h )
Hubba.update_traffic( h )


