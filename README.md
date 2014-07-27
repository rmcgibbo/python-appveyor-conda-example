python-appveyor-conda-example
=============================

Demo project for building Python conda packages with appveyor.com


Binstar
-------

Binstar.org is a website for hosting public and private conda packages. To upload
your conda binaries built on Appveyor to binstar, you'll first need to create
a binstar token to authenticate the appveyor server with binstar.

This command will require entering your binstar credentials, and produce a token.
```
$ binstar auth -n name-of-your-token -o omnia --max-age 22896000 -c --scopes api:read,api:write
```

The token grants its owner write permissions to your binstar account, so you
won't want to put it into your (public) appveyor.yml file without first encrypting
it. Copy and paste the token into [this form on the appveyor appveyor website](https://ci.appveyor.com/tools/encrypt)
to  encrypt the token. It will give you a snippet to add to your `appveyor.yml`
file, e.g.

```
environment:
  binstar_token:
    secure: rZK3KxBEutYRFw3p2HvU8CQvCDvgC5391CxVv2mTCKTTjLJLtGDVvfYoMPqV7JJz
```
