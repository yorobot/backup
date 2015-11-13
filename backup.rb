# encoding: utf-8

require 'yaml'
require 'pp'
require 'fileutils'


class Repo
  def initialize( owner, name )
    @owner = owner    ## use/rename to login or something - why? why not??
    @name  = name     #  e.g. "rubylibs/webservice"
  end

  def clone_url
     ##  check: use https: as default? for github - http:// still supported? or redirected?
    "http://github.com/#{@owner}/#{@name}"
  end

  def git_dir
     ## todo: rename to use bare_git_dir or mirror_dir  or something ??
     "#{@name}.git"
  end

  def backup( dest_dir )
    ##
    # system returns
    #  - true if the command gives zero exit status,
    #  - false for non zero exit status.
    #  - nil if command execution fails. An error status is available in $?.

    ###
    ##  use --mirror
    ##  use -n  (--no-checkout)   -- needed - why? why not?

    result = nil

    Dir.chdir( dest_dir ) do
      if Dir.exist?( git_dir )
        Dir.chdir( git_dir ) do
          cmdline = "git remote update" 
          puts "  try updating >#{cmdline}< in (#{Dir.pwd})..."
          result = system( cmdline )
        end
      else
        cmdline = "git clone --mirror #{clone_url}"
        puts "  try cloning >#{cmdline}< in (#{Dir.pwd})..."
        result = system( cmdline )
      end
    end

    pp result

    ## note: system returns true if the command gives zero exit status,
    ##  false for non zero exit status.
    ## Returns nil if command execution fails. An error status is available in $?.

    if result.nil?
      puts "*** error was #{$?}"
      fail "[Kernel.system] command execution failed - #{$?}"
    elsif result   ## true => zero exit code (OK)
      puts 'OK'  ## zero exit; assume OK
    else  ## false => non-zero exit code (ERR/NOK)       ###  todo/fix: log error and continue ??
      puts "*** error: non-zero exit!!"   ## non-zero exit (e.g. 1,2,3,etc.); assume error
      ## fail "[Kernel.system] command execution failed - non-zero exit code"
      
      ## log error for now
      File.open( './errors.log', 'a' ) do |f|
        f.write "#{Time.now} -- repo #{@owner}/#{@name} - command execution failed - non-zero exit\n"
      end
      
      ## todo/fix: return false - for allow retry or something - why? why not??
    end
    true  ## assume ok
  end ## method backup

end   ## class Repo



backup_dir = "~/backup/#{Date.today.strftime('%Y-%m-%d')}"   ## e.g. 2015-07-21
backup_dir = File.expand_path( backup_dir )
pp backup_dir

FileUtils.mkdir_p( backup_dir )   ## make sure path exists



repos = YAML.load_file( './repos.yml')

## pp repos

org_count   = 0
repo_count  = 0

repos.each do |key_with_counter,values|

  ## remove optional number from key e.g.
  ##   mrhydescripts (3)    =>  mrhydescripts
  ##   footballjs (4)       =>  footballjs
  ##   etc.
  
  key = key_with_counter.sub( /\s+\([0-9]+\)/, '' )

  puts "  -- #{key_with_counter} [#{key}] --"

  dest_dir = "#{backup_dir}/#{key}"
  FileUtils.mkdir_p( dest_dir )   ## make sure path exists

  values.each_with_index do |value,i|
    puts " \##{repo_count+1} [#{i+1}/#{values.size}] #{value}"

    puts "     #{key}/#{value}"
    repo = Repo.new( key, value )  ## owner, name e.g. rubylibs/webservice
    repo.backup( dest_dir )

    repo_count += 1

    ## exit if repo_count > 3
  end

  org_count += 1  
end

## print stats

puts "  #{org_count} orgs, #{repo_count} repos"

