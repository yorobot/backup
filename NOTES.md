# Notes
## Todos


- [ ] check if orgs.yml is used anywhere? remove/delete?



## add stars / starcount to SUMMARY.md


## fix - check http status in githubba response e.g. 301 (Moved Permanently) etc.

```
add record 2017-02-11 to history...
GET /repos/slideshow-s9/slideshow-models/commits
  using basic auth - user: testdada, password: ***
"server => GitHub.com"
"date => Sat, 11 Feb 2017 18:45:49 GMT"
"content-type => application/json; charset=utf-8"
"content-length => 160"
"connection => close"
"status => 301 Moved Permanently"
"x-ratelimit-limit => 5000"
"x-ratelimit-remaining => 4288"
```



##  double check org membership (must be public)

check if set to public (otherwise org will NOT get included in api call)

add excludes / skip (for too large repos e.g. bootstrap or w/ media files etc.) e.g.:

```
jekyll-octopod (4):
- jekyll-octopod
- jekyll-octopod.github.io
- jekyll-octopod.github.io.source
- staging
```

## add auto-save to github client

add auto-save;  what to do with query parameters (e.g.?per-page=100):
- strip ??  or
- include - why? why not??


## more

change gerald.json  to users~geraldb.json  - e.g. 1:1

keeps it generic e.g. no url/uri mapping required


## config

use a /config folder for   repos.yml, org.yml etc.  - why? why not??


## handle errors - resume backup on error ???

~~~
 #24 [2/7] build
     beercsv/build
try >git clone --mirror -n http://github.com/beercsv/build< in (C:/Users/VHHBG02/backup/2015-11-11/beercsv)...
Cloning into bare repository 'build.git'...
fatal: unable to access 'http://github.com/beercsv/build/': Recv failure: Connection was reset
false
*** error: non-zero exit!!
./backup.rb:41:in `backup': [Kernel.system] command execution failed - non-zero exit code (RuntimeError)
        from ./backup.rb:83:in `block (2 levels) in <main>'
        from ./backup.rb:78:in `each'
        from ./backup.rb:78:in `each_with_index'
        from ./backup.rb:78:in `block in <main>'
        from ./backup.rb:64:in `each'
        from ./backup.rb:64:in `<main>'
~~~