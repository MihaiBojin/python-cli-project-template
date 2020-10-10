# Python CLI tool template

A simple template for setting up a Python CLI project from scratch.

# Quickstart

- Start by creating a new repository, based on this template.
- Clone the new repository.
- Initialize a virtualenv: `make venv-init`
- Activate it: `source $(make activate)`
- Run the generic tool, to confirm everything is working as expected: `tool`

# Updating dependencies

You can always update the current virtualenv by running `make venv`,
which will (re)install all the declared requirements.

You can upgrade requirements by running `make upgrade-deps`, which will check for any updates,
prompt you for a choice, and install any newly selected ones.
