require "gitti"


def ssh_clone
  #############
  ### "deep" standard/ regular clone
  [
    "yorobot/cache.github",
  ].each do |repo|
    Git.clone( "git@github.com:#{repo}.git" )
  end
end



if $PROGRAM_NAME == __FILE__
  ssh_clone()
end
