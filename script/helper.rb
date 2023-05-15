require 'cocos'

### todo/fix:
##  move .env  loader to
##    cocos - why? why not?
def load_env( path='./.env' )
  if File.exist?( path )
     puts "==> loading .env settings..."
     env = read_yaml( path )
     puts "    applying .env settings... (merging into ENV)"
     pp env
     env.each do |k,v|
         ENV[k] ||= v
     end
  end
end

load_env





## hack: use "local" hubba dev version for now
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba/lib' )
$LOAD_PATH.unshift( 'C:/Sites/rubycoco/git/hubba-reports/lib' )
require 'hubba/reports'


Hubba.config.data_dir = '../cache.github'

