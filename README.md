python-appveyor-conda-example
=============================
[![Travis Build Status](https://travis-ci.org/rmcgibbo/python-appveyor-conda-example.png?branch=master)](https://travis-ci.org/rmcgibbo/python-appveyor-conda-example)
[![Appveyor Build status](https://ci.appveyor.com/api/projects/status/ek4ufqupmnpv6ixn)](https://ci.appveyor.com/project/rmcgibbo/python-appveyor-conda-example)
[![Anaconda Badge](https://anaconda.org/rmcgibbo/pyappveyordemo/badges/version.svg)](https://anaconda.org/rmcgibbo/pyappveyordemo)

Demo project for building and shipping Python `conda` packages with AppVeyor CI
and Travis CI.

----------

AppVeyor and Travis are continuous integration (CI) platforms for Windows and Linux
respectively. Both are free for Open Source projects and run in the cloud. This
sample Python project has a simple C compiled extension. The build itself is
configured by the `setup.py` file, and orchestrated by `conda build`.

Conda is a cross-platform, Python-agnostic binary package manager. It is open
source (BSD), and is the package manager used by [Anaconda](http://docs.continuum.io/anaconda/index.html>)
scientific Python distribution. It is particularly well suited for managing
and distributing environments for the scientific Python (NumPy, SciPy) stack,
where complex system dependencies and build requirements -- e.g C and Fortran
extensions -- are the norm. For more information about `conda`, see
[this blog post](http://technicaldiscovery.blogspot.com/2013/12/why-i-promote-conda.html)
by Travis Oliphant, the original developer of NumPy and developer of `conda`.

On each commit to GitHub, both CI services perform automated builds and run the
package's tests. The package is built as a `conda` binary and directly uploaded
to [anaconda.org](https://anaconda.org)

As currently set up, 8 binary packages are built:

 - 32 bit Windows, Python 2.7
 - 32 bit Windows, Python 3.5
 - 64 bit Windows, Python 2.7
 - 64 bit Windows, Python 3.5
 - 64 bit Linux (Ubuntu 12.04), Python 2.6
 - 64 bit Linux (Ubuntu 12.04), Python 2.7
 - 64 bit Linux (Ubuntu 12.04), Python 3.4
 - 64 bit Linux (Ubuntu 12.04), Python 3.5

Users can then install these packages with

```
$ conda install -c rmcgibbo pyappveyordemo
```

Anaconda
-------

[anaconda.org](https://anaconda.org) is a website for hosting public and private `conda`
packages. To upload your conda binaries built on AppVeyor to Anaconda, you'll first
need to create an binstar token to authenticate the AppVeyor server with binstar.

This command will require entering your binstar credentials, and produce a token.

```
$ binstar auth -n name-of-your-token --max-age 22896000 -c --scopes api
```

The token grants its owner write permissions to your binstar account, so you
won't want to put it into your (public) `appveyor.yml` file without first encrypting
it. Copy and paste the token into [this form on the appveyor appveyor website](https://ci.appveyor.com/tools/encrypt)
to  encrypt the token. It will give you a snippet to add to your `appveyor.yml`
file, e.g.

```
environment:
  BINSTAR_TOKEN:
    secure: Yfr/w3h22F5s/wGT8RYrSt6jRD2UHwUm8PPWjzaGh2B3bTBZAf4uXqCO/yUnCXYe
```

To encrypt the token for inclusion in the `.travis.yml` file, use the `travis`
gem to generate the encrypted string

```
$ travis encrypt BINSTAR_TOKEN=your-binstar-token-from-above
```


Credits
-------
This demo is a fork of Olivier Grisel's (@ogrisel) [python-appveyor-demo](https://github.com/ogrisel/python-appveyor-demo),
which builds Python wheel files using the same infrastructure.

He, @FeodorFitsner, and @tomconte solved all the difficult parts of properly
configuring the Windows SDKs and MSVC environment.
