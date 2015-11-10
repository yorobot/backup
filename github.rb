# encoding: utf-8

require 'net/http'
require "net/https"
require 'uri'

require 'pp'
require 'json'
require 'yaml'


class GitHubCache    ## lets you work with  GitHub api "offline" using just a local cache of stored json

  MAPPINGS = {
    '/users/geraldb'           => 'geraldb',
    '/users/geraldb/repos'     => 'geraldb.repos',
    '/users/geraldb/orgs'      => 'geraldb.orgs',
    '/orgs/wikiscript/repos'   => 'wikiscript.repos',
    '/orgs/planetjekyll/repos' => 'planetjekyll.repos',
    '/orgs/vienna-rb/repos'    => 'vienna-rb.repos',
  }

  def initialize( dir: './cache' )
    @dir = dir
  end

  def get( request_uri )
    ## check if request_uri exists in local cache
    basename = MAPPINGS[ request_uri ]
    if basename
      path = "#{@dir}/#{basename}.json"
      text = File.read( path )   ## todo/fix:  use File.read_utf8
      json = JSON.parse( text )
    else
      nil   ## raise exception - why? why not??
    end    
  end  # method get
  
end  ## GitHubCache


class GitHubClient

def initialize
  uri = URI.parse( "https://api.github.com" )
  @http = Net::HTTP.new(uri.host, uri.port)
  @http.use_ssl = true
  @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
end # method initialize

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

end  ## GitHubClient


class GitHub       ## rename to GitHubClient or GitHubApi or GitHubWeb - why? why not??

def initialize
   @client = GitHubClient.new
   @cache  = GitHubCache.new
   
   @offline = false
end

def offline!()  @offline = true;  end   ## switch to offline  - todo: find a "better" way - why? why not?
def offline?()  @offline; end

def user( name )
  get( "/users/#{name}")
end

class UserRepos < Response
  def names
    ## sort by name
    data.map { |item| item['name'] }.sort
  end
end

def user_repos( name )
  UserRepos.new( get "/users/#{name}/repos" )
end

class Response
  attr_reader :data
  def initialize( data )
    @data = data
  end
end

class UserOrgs < Response
  def logins
    ## sort by name
    data.map { |item| item['login'] }.sort
  end
end


def user_orgs( name )
  UserOrgs.new( get "/users/#{name}/orgs" )
end


def org( name )
  get( "/orgs/#{name}" )
end

class OrgRepos < Response
  def names
    ## sort by name
    data.map { |item| item['name'] }.sort
  end
end

def org_repos( name )
  OrgRepos.new( get "/orgs/#{name}/repos" )
end


private
def get( request_uri )
  if offline?
    @cache.get( request_uri )
  else
    @client.get( request_uri )
  end
end

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

