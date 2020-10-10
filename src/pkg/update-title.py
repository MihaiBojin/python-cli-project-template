#!/usr/bin/env python
"""
Helper tool for generating the Package's Title
"""

from pyfiglet import figlet_format

from .version import __title__

# Generate a header during setup and store it into a file
output = figlet_format(__title__, font='slant', width=127)
with open("title.txt", mode='w+') as fh:
    fh.write(output)
