#!/usr/bin/env bash

set -ev

# Install miniconda to avoid compiling scipy
if test -e $HOME/miniconda/bin ; then
    echo "miniconda already installed."
else
    echo "Installing miniconda."
    rm -rf $HOME/miniconda
    mkdir -p $HOME/download
    if [[ -d $HOME/download/miniconda.sh ]] ; then rm -rf $HOME/download/miniconda.sh ; fi
    if [ "${MYCONDAPY}" = "2.7" ]; then
      if [ "${TRAVIS_OS_NAME}" = "linux" ]; then
        wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O $HOME/download/miniconda.sh;
      else
        wget https://repo.continuum.io/miniconda/Miniconda2-latest-MacOSX-x86_64.sh -O $HOME/download/miniconda.sh;
      fi;
    else
      if [ "${TRAVIS_OS_NAME}" = "linux" ]; then
        wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $HOME/download/miniconda.sh;
      else
        wget https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O $HOME/download/miniconda.sh;
      fi;
    fi

    bash $HOME/download/miniconda.sh -b -p $HOME/miniconda
fi
