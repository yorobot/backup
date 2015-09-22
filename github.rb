# encoding: utf-8

require 'net/http'
require "net/https"
require 'uri'

require 'pp'
require 'json'


class GitHub       ## rename to GitHubClient or GitHubApi or GitHubWeb - why? why not??

def initialize
  uri = URI.parse( "https://api.github.com" )
  @http = Net::HTTP.new(uri.host, uri.port)
  @http.use_ssl = true
  @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
end # method initialize


def user( name )
  get( "/users/#{name}")
end

def user_repos( name )
  get( "/users/#{name}/repos")
end

def user_orgs( name )
  get( "/users/#{name}/orgs" )
end


def org( name )
  get( "/orgs/#{name}" )
end



private
def get( request_uri )
  puts "GET #{request_uri}"

  req = Net::HTTP::Get.new( request_uri )
  ## req = Net::HTTP::Get.new( "/users/geraldb" )
  ## req = Net::HTTP::Get.new( "/users/geraldb/repos" )
  req["User-Agent"] = "ruby/github.rb"                  ## required by GitHub API 
  req["Accept" ]    = "application/vnd.github.v3+json"  ## recommend by GitHub API

  res = @http.request(req)

  # Get specific header
  # response["content-type"]
  # => "text/html; charset=UTF-8"

  # Iterate all response headers.
  res.each_header do |key, value|
    p "#{key} => #{value}"
  end
  # => "location => http://www.google.com/"
  # => "content-type => text/html; charset=UTF-8"
  # ...

  json = JSON.parse( res.body )
  pp json
  json
end  # methdo get

end  # class GitHub

=begin
def save_orgs
  gh = GitHub.new
  json = gh.user_orgs('geraldb')
  
  orgs = []
  json.each do |org|     ## note: assume array gets returned
    orgs << org['login']
  end
end
=end


def save_json( name, data )    ## data - hash or array
  File.open( "./o/#{name}", "w" ) do |f|
    f.write JSON.pretty_generate( data )
  end
end


gh = GitHub.new

save_json 'geraldb.json',       gh.user('geraldb')
save_json 'geraldb.repos.json', gh.user_repos('geraldb')
save_json 'geraldb.orgs.json',  gh.user_orgs('geraldb')

save_json 'skriptbot.json',       gh.user('skriptbot')
save_json 'skriptbot.repos.json', gh.user_repos('skriptbot')

## gh.org('planetjekyll')


