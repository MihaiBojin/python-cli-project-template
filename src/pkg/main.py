"""
Python CLI tool.

Usage:
    tool
    tool --help

"""

import importlib.resources

from docopt import docopt


def main():
    """Main entry point"""

    print_header()

    # Parse arguments
    arguments = docopt(__doc__)
    print(arguments)


def print_header():
    print(importlib.resources.open_text("pkg", "motd.txt").read())


if __name__ == "__main__":
    main()
