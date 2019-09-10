from distutils.core import setup

import setuptools
from pipenv.project import Project
from pipenv.utils import convert_deps_to_pip
# Load the project's README file
from pyfiglet import figlet_format

with open("README.md", "r", encoding='utf8') as fh:
    long_description = fh.read()

# Parse the Pipfile to retrieve all deps
# Based on this excellent example: https://github.com/pypa/pipenv/issues/209
pipfile = Project(chdir=False).parsed_pipfile
packages = convert_deps_to_pip(pipfile['packages'], r=False)
dev_packages = convert_deps_to_pip(pipfile['dev-packages'], r=False)

# Generate a header during setup and store it into a file
output = figlet_format('Python CLI tool template', font='slant', width=127)
with open("src/pkg/motd.txt", mode='w+') as fh:
    fh.write(output)

setup(
    name='Python CLI tool template',
    version='0.0.1',
    author='Mihai Bojin',
    author_email='',
    packages=setuptools.find_packages(where='src'),
    package_dir={
        '': 'src',
    },
    # https://setuptools.readthedocs.io/en/latest/setuptools.html
    package_data={
        # If any package contains *.txt files, include them:
        '': ['*.txt'],
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
    install_requires=packages + dev_packages,
    classifiers=[
        "Programming Language :: Python :: 3.7",
        "License :: OSI Approved :: Apache License Version 2.0",
        "Operating System :: POSIX",
    ],
)
