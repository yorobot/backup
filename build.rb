# encoding: utf-8


###
# todo/future:
#   use github api to double check repos (anything missing?)
#


require 'yaml'
require 'pp'


repos = YAML.load_file( './repos.yml')

## pp repos

repos.each do |key,values|

  puts "  -- #{key} --"

  values.each_with_index do |value,i|
    puts "  [#{i+1}/#{values.size}] #{value}"
    path = "#{key}/#{value}"

    puts "     #{path}"
  end

end
