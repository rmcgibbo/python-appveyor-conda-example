python-appveyor-conda-example
=============================

Demo project for building Python conda packages with appveyor.com


Binstar
-------

First, make yourself a binstar token.

```
$ binstar auth -n name-of-your-token -o omnia --max-age 22896000 -c --scopes api:write
```

Then, go to the [appveyor](https://ci.appveyor.com/tools/encrypt) website to
encrypt the token. It will give you a snippet to add to your `appveyor.yml`
file, e.g.

```
environment:
  binstar_token:
    secure: rZK3KxBEutYRFw3p2HvU8CQvCDvgC5391CxVv2mTCKTTjLJLtGDVvfYoMPqV7JJz
```

