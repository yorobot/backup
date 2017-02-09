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

Note: Set your GitHub env credentials e.g.

```
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
geraldb (16):
- viennarb
- viennarb.v01
- viennarb.v11
henrythemes (13):
- jekyll-bootstrap-theme     ## download to big - all of bootstrap ???
```

##### Update Summary

To update the summary (SUMMARY.md) use the repos script e.g.

```
$ ruby ./repos.rb
```



## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.
