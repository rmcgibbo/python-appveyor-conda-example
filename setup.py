#!/usr/bin/env python
"""Package build and install script."""

import numpy as np
from setuptools import setup, Extension
import Cython.Build


def get_version():
    """Load the version from version.py, without importing it.

    This function assumes that the last line in the file contains a variable defining the
    version string with single quotes.

    """
    with open('pycydemo/version.py', 'r') as f:
        return f.read().split('=')[-1].replace('\'', '').strip()


def get_readme():
    """Load README.rst for display on PyPI."""
    with open('README.rst') as f:
        return f.read()


setup(
    name='pycydemo',
    version=get_version(),
    description='Demo python+cython project',
    long_description=get_readme(),
    author='Toon Verstraelen',
    author_email='Toon.Verstraelen@UGent.be',
    url='https://github.com/theochem/python-cython-ci-example',
    cmdclass={'build_ext': Cython.Build.build_ext},
    package_dir={'pycydemo': 'pycydemo'},
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
