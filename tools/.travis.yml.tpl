env:
  matrix:
  - MYCONDAPY=2.7
  - MYCONDAPY=3.6
  global:
    - secure: ${TPL_ANACONDA_TOKEN}
    - secure: ${TPL_GITHUB_TOKEN}
    - secure: ${TPL_PYPI_PASSWORD}

# Do not use Travis Python to save some time.
language: generic
os:
  - linux
  - osx
osx_image: xcode6.4
dist: trusty
sudo: false

branches:
  only:
    - master
    - /^[0-9]+\.[0-9]+(\.[0-9]+)?([ab][0-9]+)?$/

install:
# Get miniconda. Take the right version, so re-installing python is hopefully not needed.
- if [[ "$MYCONDAPY" == "2.7" ]]; then
    if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
      wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda.sh;
    else
      wget https://repo.continuum.io/miniconda/Miniconda2-latest-MacOSX-x86_64.sh -O miniconda.sh;
    fi;
  else
    if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
      wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
    else
      wget https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O miniconda.sh;
    fi;
  fi
- bash miniconda.sh -b -p $HOME/miniconda
- source $HOME/miniconda/bin/activate
- hash -r

# Configure conda and get a few essentials
- conda config --set always_yes yes
- conda update -q conda
# Install extra package needed to make things work. Most things can be listed as
# dependencies on metal.yaml and setup.py, unless setup.py already imports them.
# Install conda tools for packaging and uploading
- conda install python=${MYCONDAPY} numpy cython sphinx conda-build anaconda-client
# Install more recent stuff with pip
- pip install codecov coverage pylint pycodestyle pydocstyle
# Show conda info for debugging
- conda info -a

# Install the latest cardboardlinter
- if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
    pip install --upgrade git+https://github.com/theochem/cardboardlint.git@master#egg=cardboardlint;
  fi

# Set the version info from the git tag
- git fetch origin --tags
- export PROJECT_VERSION=$(python tools/gitversion.py)
- python tools/gitversion.py python > ${PROJECT_NAME}/version.py

script:
# Static linting
# --------------
- if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
    cardboardlinter --refspec $TRAVIS_BRANCH -f static;
  fi

# Testing with conda package
# --------------------------

# Build the conda package
- conda build -q tools/conda.recipe
# Install Conda package
- conda install --use-local ${PROJECT_NAME}
# Run the unittests, using the installed package
- (cd; nosetests ${PROJECT_NAME} -v --detailed-errors)

# In-place building and testing
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# This is allows for coverage analysis and dynamic linting. The compiler settings used
# here are not suitable for releases, so we need to recompile and rerun the tests.

# Install GCC compilers for in-place builds, even on OSX because clang does not manage to
# compiler our C++ code.
- conda install gcc libgcc;

# Uninstall conda package, to be sure. The conda cpp package is still used.
- conda uninstall ${PROJECT_NAME}
- python setup.py build_ext -i --define CYTHON_TRACE_NOGIL
# Run nosetests without coverage.xml output. That file is broken by nosetests (pyx files
# not include) and gets priority over .coverage, which contains everything.
- coverage erase;
  nosetests ${PROJECT_NAME} -v --detailed-errors --with-coverage --cover-package=${PROJECT_NAME} --cover-tests --cover-inclusive --cover-branches;
  coverage xml -i
# Dynamic linting
- if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
    cardboardlinter --refspec $TRAVIS_BRANCH -f 'dynamic';
  fi

# Some other stuff
# ----------------

# Build source package, should work too and needed for deployment to Github and
# PyPI.
- python setup.py sdist

# Compile documentation
- (cd doc; make html)

after_success:
# Upload the coverage analysis
- codecov -f coverage.xml

before_deploy:
# Try to set some env vars to configure deployment.
# Please keep the following lines. They will be used again as soon as it is supported on
# travis. See https://github.com/travis-ci/dpl/issues/613
#- export IS_PRERELEASE=$(python -c 'import os; tt=os.environ["TRAVIS_TAG"]; print("true" if ("a" in tt or "b" in tt) else "false")')
#- echo ${IS_PRERELEASE}
- export ANACONDA_LABEL=$(python -c 'import os; tt=os.environ["TRAVIS_TAG"]; print("alpha" if ("a" in tt) else ("beta" if "b" in tt else "main"))')
- echo ${ANACONDA_LABEL}

# In deployment, the env var TRAVIS_TAG contains the name of the current version, if any.
deploy:
- provider: releases
  skip_cleanup: true
  api_key: ${GITHUB_TOKEN}
  file: dist/${PROJECT_NAME}-${TRAVIS_TAG}.tar.gz
  on:
    repo: ${GITHUB_REPO_NAME}
    tags: true
    condition: "$MYCONDAPY == 2.7 && $TRAVIS_OS_NAME == linux && $TRAVIS_TAG == *[ab]*"
  prerelease: true

- provider: releases
  skip_cleanup: true
  api_key: ${GITHUB_TOKEN}
  file: dist/${PROJECT_NAME}-${TRAVIS_TAG}.tar.gz
  on:
    repo: ${GITHUB_REPO_NAME}
    tags: true
    condition: "$MYCONDAPY == 2.7 && $TRAVIS_OS_NAME == linux && $TRAVIS_TAG != *[ab]*"
  prerelease: false

- provider: script
  skip_cleanup: true
  script: anaconda -t $ANACONDA_TOKEN upload --force -l ${ANACONDA_LABEL} ${HOME}/miniconda/conda-bld/*/${PROJECT_NAME}-*.tar.bz2
  on:
    repo: ${GITHUB_REPO_NAME}
    tags: true

- provider: pypi
  skip_cleanup: true
  user: theochem
  password: ${PYPI_PASSWD}
  on:
    repo: ${GITHUB_REPO_NAME}
    tags: true
    condition: "$TRAVIS_TAG != *[ab]* && $MYCONDAPY == 2.7 && $TRAVIS_OS_NAME == linux"

- provider: pages
  skip_cleanup: true
  github_token: ${GITHUB_TOKEN}
  project_name: ${PROJECT_NAME}
  local_dir: doc/_build/html
  on:
    repo: ${GITHUB_REPO_NAME}
    condition: "$TRAVIS_TAG != *[ab]* && $MYCONDAPY == 2.7 && $TRAVIS_OS_NAME == linux"
    tags: true
