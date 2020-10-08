

def save_orgs
  gh = Hubba::Github.new

  h = {}
  user = 'geraldb'
  res = gh.user_orgs( user )
  save_json( "users~#{user}~orgs", res.data )
  orgs = res.logins

  h[ "#{user} (#{orgs.size})" ] = orgs

  save_yaml( "orgs", h )
end  ## method save_repos
