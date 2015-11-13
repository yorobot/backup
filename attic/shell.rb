
## try using Shell class
##    so far not working; cannot find/run git
#
#  C:/prg/ri/v310/Ruby2.1.0/lib/ruby/2.1.0/shell/command-processor.rb:383:
#      in `find_system_command': Command not found(git).
#   (Shell::Error::CommandNotFound)


  def sh()  @shell ||= Shell.new;  end

  def backup_with_shell( dest_dir )
    ##
    # system returns
    #  - true if the command gives zero exit status,
    #  - false for non zero exit status.
    #  - nil if command execution fails. An error status is available in $?.

    ###
    ##  use --mirror
    ##  use -n  (--no-checkout)   -- needed - why? why not?

    ## Shell.def_system_command( 'git', 'git' ) 

    pp sh.system_path
    sh.system( 'git --version' )
    ## sh.system( 'git --version' )
    ## sh.system( 'ruby --version' )
    ## sh.run( 'git --version' )

    result = nil

    sh.cd( dest_dir ) do
      if sh.exists?( git_dir )
        sh.cd( git_dir ) do
          cmdline = "git remote update" 
          puts "  try updating >#{cmdline}< in (#{sh.pwd})..."
          result = sh.system( cmdline )    ### use sh.run instead - why? why not?
        end
      else
        cmdline = "git clone --mirror #{clone_url}"
        puts "  try cloning >#{cmdline}< in (#{sh.pwd})..."
        result = sh.system( cmdline )    ### use sh.run instead - why? why not?
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
        f.write "#{Time.now} -- repo #{owner}/#{name} - command execution failed - non-zero exit\n"
      end
      
      ## todo/fix: return false - for allow retry or something - why? why not??
    end
    true  ## assume ok
  end ## method backup

