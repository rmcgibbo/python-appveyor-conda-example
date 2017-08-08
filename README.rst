.. image:: https://travis-ci.org/tovrstra/python-cython-ci-example.svg?branch=master
    :target: https://travis-ci.org/tovrstra/python-cython-ci-example
.. image:: https://ci.appveyor.com/api/projects/status/e5anh744b456p5at/branch/master?svg=true
    :target: https://ci.appveyor.com/project/tovrstra/python-cython-ci-example
.. image:: https://anaconda.org/tovrstra/pycydemo/badges/version.svg
    :target: https://anaconda.org/tovrstra/pycydemo

Demo project for building and deploying a Python+Cython packages with AppVeyor
CI and Travis CI.

This is based on a similar demo: https://github.com/tovrstra/python-appveyor-conda-example
Additional features:

- Less auxiliary scripts, making more use of recent Travis and AppVeyor built-in
  features. This should be easier to understand and adapt.
- Conda packages for win-32, win-64, linux-64, osx-64.
- Python 2.7, 3.5, 3.6.
- Upload to alpha, beta and main channels on Anaconda cloud.
- Github stable and prerelease source release.
- PyPI source release. Stable releases only stable only, because others are not
  safe to upload to PyPI.
- Documentation deployment to gh-pages (Travis).
- CI Testing after installation on Travis or AppVeyor instance.
