
def backup( repo, dest_dir )

  ##
  # system returns
  #  - true if the command gives zero exit status,
  #  - false for non zero exit status.
  #  - nil if command execution fails. An error status is available in $?.

  ###
  ##  use --mirror
  ##  use -n  (--no-checkout)
  ##  check: use https: as default? for github - http:// still supported? or redirected?

  cmdline = "git clone --mirror -n http://github.com/#{repo}"

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
