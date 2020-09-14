# backup

scripts to backup repos, etc.



## Usage

To backup all repos use:

```
$ ruby ./backup.rb
```

All repos get git cloned in the backup folder in home (e.g. `~/backup`)
with an extra folder for the date e.g. (`2015-08-21`):

``` ruby
backup_dir = "~/backup/#{Date.today.strftime('%Y-%m-%d')}"
```


### More

#### Update Datafiles

To update the datafiles (orgs.yml and repos.yml) for organizations and repos
to backup use the online script e.g.

```
$ ruby ./online.rb
```

Note: Set your GitHub env credentials (personal access token preferred) e.g.

```
set HUBBA_TOKEN=abcdef0123456789
#   - or -
set HUBBA_USER=you
set HUBBA_PASSWORD=topsecret
```

Note: For now these repos get auto-excluded in repos.yml:

```
RubyHabits (9):
- Graphics
- Slides
- movie-catalog
- nyan-cat
- recipes
- ruby-habits-library
- rubyhabits.github.io
- secret-collect
- webpage
jekyll-octopod (6):
- jekyll-bootflat
- jekyll-octopod
- jekyll-octopod.github.io
- jekyll-octopod.github.io.source
- jekyllthemes
- staging
vienna-rb (5):
- ....
```

And exclude (comment out) these by-hand:

```
henrythemes (13):
- jekyll-bootstrap-theme     ## download to big - all of bootstrap ???
cryptocopycats (6):
- kitties                    ## download to big
```



##### Update Summary

To update the summary (SUMMARY.md) use the repos script e.g.

```
$ ruby ./summary.rb
```



## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.
