from setuptools import setup
from setuptools import Extension
from Cython.Build import cythonize


setup(name="update4_5", ext_modules=cythonize('update4_5.pyx'),)