default: usage

clean:
ifdef PIPENV_ACTIVE
	$(error Cannot clean the environment, if one is already active. 'exit' first...)
endif
	@echo "==> Cleaning working directory..."
	@find . -name '*.egg-info' | xargs rm -rf
	@rm -rf __pycache__ .pytest_cache

devenv:
	@echo "==> Updating the local development environment..."
	@pipenv update
ifndef PIPENV_ACTIVE
	@echo "==> Activating the pipenv shell..."
	@pipenv shell
endif

devenv-install: clean
ifdef PIPENV_ACTIVE
	$(error "Cannot install the environment, if one is already active. 'exit' first!")
endif
	@echo "==> Setting up the project for local development..."
	@pipenv clean
	$(MAKE) install
	@pipenv shell

install: install-pipenv
	@echo "==> Resolving dependencies..."
	@pipenv install --dev
	@pipenv run pip install -e .

install-git-hooks:
	@echo "==> Installing all git hooks..."
	find .git/hooks -type l -exec rm {} \;
	find .githooks -type f -exec ln -sf ../../{} .git/hooks/ \;

install-pipenv:
ifeq (, $(shell which pipenv))
	@echo "==> Installing pipenv..."
	@python -m pip install --upgrade pipenv
endif

run:
	@pipenv run tool

style:
	@echo "==> Formatting code..."
	pipenv run autopep8 --in-place --aggressive --recursive .

	@echo "==> Checking code style..."
	pipenv run flake8 .

test:
	@echo "==> Running tests..."
	@pipenv run pytest .

usage:
	@echo "Usage:"
	@echo "clean: Removes build artifacts from the current working directory"
	@echo "devenv: Updates and activates the local development environment"
	@echo "devenv-install: Sets up a local development environment"
	@echo "install-git-hooks: Installs git hooks in the current working directory"
	@echo "run: Runs the tool's entry point from outside the venv"
	@echo "style: Formats the source code and then runs linting"
	@echo "test: Runs all tests"
	@echo

.PHONY: clean default devenv devenv-install install run style test usage
