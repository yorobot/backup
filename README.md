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


## Meta

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.
