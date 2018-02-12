# encoding: utf-8


require 'hubba'    ## used in "offline" mode (e.g. reads stats from ./data folder)



class GitHubStats


class Repo

  attr_reader :owner, :name, :stats
  def full_name() "#{owner}/#{name}"; end

  def initialize( owner, name, data_dir: './data' )
    @owner = owner
    @name  = name

    @stats = Hubba::Stats.new( full_name )
    @stats.read( data_dir: data_dir )
  end

  def diff()  @diff ||= stats.calc_diff_stars( samples: 3, days: 30 ); end

end  # class Repo



def self.from_file( path, data_dir: './data' )
  h = YAML.load_file( path )
  pp h
  new( h, data_dir: data_dir )
end


attr_reader :orgs, :repos

def initialize( hash, data_dir: './data' )
  @orgs     = []    # orgs and users -todo/check: use better name - logins or owners? why? why not?
  @repos    = []
  @data_dir = data_dir
  add( hash )
end


def add( hash )   ## add repos.yml set
  hash.each do |key_with_counter,values|
    key = key_with_counter.sub( /\s+\([0-9]+\)/, '' )
    repos = []
    values.each do |value|
      repo = Repo.new( key, value, data_dir: @data_dir  )
      repos << repo
    end
    @orgs  << [key, repos]
    @repos += repos
  end
end

end # class GitHubStats
