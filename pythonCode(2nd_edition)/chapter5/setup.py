from setuptools import setup
from setuptools import Extension
from Cython.Build import cythonize


setup(name="race_track_fun", ext_modules=cythonize('race_track_fun.pyx'),)