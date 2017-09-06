.. image:: https://travis-ci.org/theochem/python-cython-ci-example.svg?branch=master
    :target: https://travis-ci.org/theochem/python-cython-ci-example
.. image:: https://ci.appveyor.com/api/projects/status/ora4yr7kot2ffr8x/branch/master?svg=true
    :target: https://ci.appveyor.com/project/theochem-travis-uploader/python-cython-ci-example
.. image:: https://anaconda.org/theochem/pycydemo/badges/version.svg
    :target: https://anaconda.org/theochem/pycydemo
.. image:: https://codecov.io/gh/theochem/python-cython-ci-example/branch/master/graph/badge.svg
    :target: https://codecov.io/gh/theochem/python-cython-ci-example

Demo project for building and deploying a Python+Cython packages with AppVeyor
CI and Travis CI.

This is based on a similar demo: https://github.com/theochem/python-appveyor-conda-example
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
- Code coverage with codecov.io.


The CI machinery in this project is "easily" used in other projects. The following files/parts need to be copied over (and modified):

- The version stuff from ``setup.py`` and ``pycydemo/__init__.py``. This extracts the version from the latest git tag. Ideally, no other places in your project should define (another) version. Also mind the following in ``setup.py``:
    - ``zip_safe=False`` (for nosetests and conda packaging) See https://github.com/nose-devs/nose/issues/1057
    - Order of importing ``setuptools`` and ``Cython`` matters.
- Copy ``tools/conda.recipe/meta.yaml`` and change the package name and dependencies.
- Copy ``.travis.yml`` and update the ``env`` block, including new encrypted tokens and passwords.
- For windows testing: copy ``.appveyor.yml`` and update the ``env`` block, including new encrypted tokens and passwords.

Making tokens:

- Github: https://github.com/settings/tokens (scopes repo:public_repo)
- Anaconda: https://anaconda.org/theochem/settings/access Scopes:
    - api:read (Allow read access to the API site)
    - api:write (Allow write access to the API site)

Encrypting tokens (Github, Anaconda) and passwords (PyPI) on Travis-CI:

- Basic documentation: https://docs.travis-ci.com/user/encryption-keys/
- Best usage is to just run `travis encrypt` without arguments. Then enter a variable and content in the form ``VAR=pass``. Press enter. Press Ctrl-d.
- Copy the encrypted stuff to the ``env`` section of ``.travis.yml``

Encrypting tokens (Anaconda) and passwords on AppVeyor:

- Use https://ci.appveyor.com/tools/encrypt
- Only enter the password or token itself, so only the ``pass`` part of ``VAR=pass``. The ``VAR`` is still visible in .appveyor.tml``.
- Copy to ``.appveyor.yml``.
