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

  ## todo/fix: move/add to Hubba::Stats
  def created_at() stats.created_at ? DateTime.strptime( stats.created_at, '%Y-%m-%dT%H:%M:%S') : nil; end
  def updated_at() stats.updated_at ? DateTime.strptime( stats.updated_at, '%Y-%m-%dT%H:%M:%S') : nil; end
  def pushed_at()  stats.pushed_at  ? DateTime.strptime( stats.pushed_at,  '%Y-%m-%dT%H:%M:%S') : nil; end


  def diff()  @diff ||= calc_diff;  end


  def calc_diff
    ### todo: cache value - why? why not??
    ##  todo: calculate per month or per week
    ##    use sample of three data points (if available)

    history_keys  = stats.history.keys.sort.reverse
    history       = stats.history

    if history_keys.size >= 2
      h0 = history[ history_keys[0] ]
      h1 = history[ history_keys[1] ]
      stars0 = h0['stargazers_count'] || 0
      stars1 = h1['stargazers_count'] || 0
      d0 = Date.strptime( history_keys[0], '%Y-%m-%d' )
      d1 = Date.strptime( history_keys[1], '%Y-%m-%d' )

      ## check for shortcut; stars count is 1
      if stars0 == 1
        diff = 0
      else
        stars_diff = stars0 - stars1
        days_diff  = d0.jd - d1.jd
        puts "diff stars-diff / days_diff = #{stars_diff} / #{days_diff} = #{stars_diff/days_diff}, #{(stars_diff*70/days_diff)}/week"
        diff = (stars_diff*70 / days_diff )    ## use stars/week (diff in 7 days)
      end
    else
      diff = 0
    end

    diff
  end


  def show_history
    buf = ''
    last_date  = nil
    last_stars = nil

    history_keys  = stats.history.keys.sort.reverse
    history       = stats.history

    buf << "[#{history.size}]: "

    history_keys.each do |key|
       h = history[ key ]
       stars = h['stargazers_count'] || 0
       date  = Date.strptime( key, '%Y-%m-%d' )

       if last_date && last_stars
         stars_diff = last_stars   - stars
         days_diff  = last_date.jd - date.jd

         if stars_diff > 0 || stars_diff < 0
           if stars_diff > 0
             buf << " (+#{stars_diff}"
           else
             buf << " (#{stars_diff}"
           end
           buf << " in #{days_diff}d) "
         else
           buf << " (#{days_diff}d) "
         end
       end
       last_date =  date
       last_stars = stars

       buf << "#{stars}"
    end
    buf
  end # mehtod show_history

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
