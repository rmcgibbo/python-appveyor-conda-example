from setuptools import setup, Extension
from Cython.Build import cythonize

extension_module = Extension(
    'pyappveyordemo.extension',
     sources=['pyappveyordemo/extension.pyx']
)


setup(
    name = 'python-appveyor-demo',
    version = '1.0',
    description = 'This is a demo package with a compiled C extension.',
    ext_modules = cythonize([extension_module]),
    zip_safe=False,
    packages=['pyappveyordemo', 'pyappveyordemo.tests'],
)