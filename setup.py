from distutils.core import setup
import setuptools
from src.pkg.version import __version__, __title__

with open("README.md", "r", encoding='utf8') as fh:
    long_description = fh.read()

# Parse requirements.txt
packages = list()
with open('requirements/prod.txt') as fh:
    for line in fh.readlines():
        dep = line.strip()
        # skip empty lines
        if len(dep) == 0:
            continue

        # skip comments
        if dep[0] == '#':
            continue

        # Extract any comments
        parts = dep.split('#', 1)
        packages += [parts[0]]

setup(
    name=__title__,
    version=__version__,
    author='John Doe',
    author_email='',
    packages=setuptools.find_packages(where='src'),
    package_dir={
        '': 'src',
    },
    # https://setuptools.readthedocs.io/en/latest/setuptools.html
    package_data={
        '': ['*.txt', '*.yml', '*.json'],
    },
    scripts=[],
    entry_points={
        'console_scripts': [
            'tool = pkg.main:main',
        ]
    },
    url='http://pypi.python.org/pypi/[your-project-name-here]/',
    license='LICENSE',
    description='Python CLI tool template',
    long_description=long_description,
    long_description_content_type="text/markdown",
    install_requires=packages,
    classifiers=[
        "Programming Language :: Python :: 3.7",
        "License :: OSI Approved :: Apache License Version 2.0",
        "Operating System :: POSIX",
    ],
)
