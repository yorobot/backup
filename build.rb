# encoding: utf-8


###
# todo/future:
#   use github api to double check repos (anything missing?)
#


require 'yaml'
require 'pp'
require 'fileutils'



def backup( repo, dest_dir )

  ##
  # system returns
  #  - true if the command gives zero exit status,
  #  - false for non zero exit status.
  #  - nil if command execution fails. An error status is available in $?.

  cmdline = "git clone http://github.com/#{repo}"

  result = nil

  Dir.chdir( dest_dir ) do
    puts "try >#{cmdline}< in (#{Dir.pwd})..."
    result = system( cmdline )
    ## result = true
  end

  pp result

  if result.nil?
    puts "*** error was #{$?}"
    fail "[Kernel.system] command execution failed - #{$?}"
  elsif result   ## true == zero exit code
    puts 'OK'  ## zero exit; assume OK
  else  ## false == non-zero exit code
    puts "*** error: non-zero exit!!"   ## non-zero exit (e.g. 1,2,3,etc.); assume error
    fail "[Kernel.system] command execution failed - non-zero exit code"
  end
  true  ## assume ok
end




backup_dir = "~/backup/#{Date.today.strftime('%Y-%m-%d')}"   ## e.g. 2015-07-21
backup_dir = File.expand_path( backup_dir )
pp backup_dir

FileUtils.mkdir_p( backup_dir )   ## make sure path exists



repos = YAML.load_file( './repos.yml')

## pp repos

org_count   = 0
repo_count  = 0

repos.each do |key,values|

  puts "  -- #{key} --"

  dest_dir = "#{backup_dir}/#{key}"
  FileUtils.mkdir_p( dest_dir )   ## make sure path exists

  values.each_with_index do |value,i|
    puts " \##{repo_count+1} [#{i+1}/#{values.size}] #{value}"
    path = "#{key}/#{value}"

    puts "     #{path}"
    backup( path, dest_dir )

    repo_count += 1

    ## exit if repo_count > 1
  end

  org_count += 1  
end

## print stats

puts "  #{org_count} orgs, #{repo_count} repos"

