####
## convert datasets to new a-z indexed format

require 'pp'
require 'yaml'
require 'fileutils'


all = YAML.load_file( "./config/repos.yml" )
pp all


all.each do |org_with_counter,names|
  org = org_with_counter.sub( /\([0-9]+\)/, '' ).strip
  names.each do |name|
    basename = "#{org}~#{name}"
    path = "./data/#{basename}.json"
    puts "reading #{path}..."
    txt = File.open( path, 'r:utf-8' ) { |f| f.read }

    letter = org[0]
    outpath = "../cache.github/#{letter}/#{basename}.json"

    FileUtils.mkdir_p( File.dirname( outpath ) )
    File.open( outpath, 'w:utf-8' ) { |f| f.write( txt ) }
  end
end

