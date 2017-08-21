#!/usr/bin/env python

from __future__ import print_function

import numpy as np
from setuptools import setup, Extension
import Cython.Build

from tools.gitversion import get_gitversion

def readme():
    with open('README.rst') as f:
        return f.read()

setup(
    name='pycydemo',
    version=get_gitversion('pycydemo', verbose=(__name__=='__main__')),
    description='Demo python+cython project',
    long_description=readme(),
    author='Toon Verstraelen',
    author_email='Toon.Verstraelen@UGent.be',
    url='https://github.com/theochem/python-cython-ci-example',
    cmdclass={'build_ext': Cython.Build.build_ext},
    package_dir = {'pycydemo': 'pycydemo'},
    packages=['pycydemo', 'pycydemo.tests'],
    ext_modules=[Extension(
        'pycydemo.extension',
        sources=['pycydemo/extension.pyx'],
        include_dirs=[np.get_include()],
    )],
    zip_safe=False,
    setup_requires=['numpy>=1.0', 'cython>=0.24.1'],
    install_requires=['numpy>=1.0', 'nose>=0.11', 'cython>=0.24.1'],
)
