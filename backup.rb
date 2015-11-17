# encoding: utf-8

require 'yaml'
require 'pp'
require 'fileutils'


## 3rd party gems/libs
require 'gitta'
include Gitta    ## lets you use Git, GitError, etc.


class GitHubBareRepo    ## use/rename to GitHubServerRepo - why? why not?
  def initialize( owner, name )
    @owner = owner    ## use/rename to login or something - why? why not??
    @name  = name     #  e.g. "rubylibs/webservice"
  end

  def http_clone_url   ## use clone_url( http: true )  -- why? why not?
     ##  check: use https: as default? for github - http:// still supported? or redirected?
    "http://github.com/#{@owner}/#{@name}"
  end

  def git_dir
     ## todo: rename to use bare_git_dir or mirror_dir  or something ??
     "#{@name}.git"
  end


  def backup_with_retries( dest_dir, retries: 2 )
    retries_count = 0
    success = false
    begin
      success = backup( dest_dir )
      retries_count += 1
    end until success || retries_count >= retries
    success   ## return if success or not  (true/false)
  end

  def backup( dest_dir )
    ###
    ##  use --mirror
    ##  use -n  (--no-checkout)   -- needed - why? why not?

    Dir.chdir( dest_dir ) do
      if Dir.exist?( git_dir )
        Dir.chdir( git_dir ) do
          Git.remote_update
        end
      else
        Git.mirror( http_clone_url )
      end
    end
    true  ## return true  ## success/ok
  rescue GitError => ex
    puts "*** error: #{ex.message}"
    
    File.open( './errors.log', 'a' ) do |f|
      f.write "#{Time.now} -- repo #{@owner}/#{@name} - #{ex.message}\n"
    end
    false ## return false  ## error/nok
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

    repo    = GitHubBareRepo.new( key, value )  ## owner, name e.g. rubylibs/webservice
    success = repo.backup_with_retries( dest_dir )   ## note: defaults to two tries   
    ## todo/check:  fail if success still false after x retries? -- why? why not?

    repo_count += 1

    ###  exit if repo_count > 2
  end

  org_count += 1  
end

## print stats

puts "  #{org_count} orgs, #{repo_count} repos"

