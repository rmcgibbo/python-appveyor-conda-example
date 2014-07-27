import os
from setuptools import setup, Extension
from Cython.Build import cythonize

#####################################
VERSION = "1.0"
ISRELEASED = False
__version__ = VERSION
#####################################


extension_module = Extension(
    'pyappveyordemo.extension',
     sources=['pyappveyordemo/extension.pyx']
)


if os.environ['CONDA_BUILD']:
    with open('__conda_version__.txt', 'w') as f:
        if ISRELEASED:
            f.write(VERSION)
        else:
            f.write(VERSION + '.dev')

setup(
    name = 'python-appveyor-demo',
    version = VERSION,
    description = 'This is a demo package with a compiled C extension.',
    ext_modules = cythonize([extension_module]),
    zip_safe=False,
    packages=['pyappveyordemo', 'pyappveyordemo.tests'],
)
