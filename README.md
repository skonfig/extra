# cdist-contrib

This project extends the [cdist][cdist] configuration management
tool with community-maitained types which are either too specific to fit/be
maintained in cdist itself or were not accepted in code cdist but could still
be useful.

This project does not have releases and is continously updated: see git history
for change log. You will find HTML documentation at
[contrib.cdi.st](https://contrib.cdi.st).

## Using cdist-contrib

We would recommend that you clone this repository next to your regular cdist
config directory, then setup `conf_dir` with relative paths in
[cdist configuration][cdistconfig].

An example of this would be:

```ini
# contents of cdist.cfg next to cdist-contrib
[GLOBAL]
# Notice that types defined in last dir win and can override native types.
# Consider using a prefix for your own types to avoid collisions.
conf_dir = cdist-contrib:cdist-private
```

And you would run [cdist][cdist] from the same directory as follows:

    cdist config -g cdist.cfg
    # Or setup your CDIST_CONFIG_FILE environment variable and run as usual


## Participating in the [cdist][cdist] community

Join us on [#cdist:ungleich.ch][cdistmatrix] on matrix!

[cdist]: https://www.cdi.st/
[cdistconfig]: https://www.cdi.st/manual/latest/cdist-configuration.html
[cdistmatrix]: https://matrix.to/#/#cdist:ungleich.ch

## Contributing

The preferred way to submit patches is by opening Merge Requests against the
[cdist-contrib project on
code.ungleich.ch](https://code.ungleich.ch/ungleich-public/cdist-contrib) (you
can make an account on
[account.ungleich.ch](https://account.ungleich.ch/).

Every type in cdist-contrib must:

  * Have a `man.rst` documentation page.
  * Pass [shellcheck](http://shellcheck.net/) without errors.

## Other resources

Some people/organizations are known to keep some cdist types that might be of
interest to others:

* [cdist-evilham](https://git.sr.ht/~evilham/cdist-evilham): Evilham's cdist-types
* [cdist-recycledcloud](https://code.recycled.cloud/e-Durable/cdist-recycledcloud): e-Durable SA / Recycled Cloud public types
* [cdist-ungleich](https://code.ungleich.ch/ungleich-public/cdist-ungleich): ungleich public types
