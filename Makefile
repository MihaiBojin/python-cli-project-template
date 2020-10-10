VENV := ".venv"
PIP_VERSION := "20.2.3"
SOURCE_CODE := "src/"
default: usage

.PHONY: activate
activate:
	@echo "$(VENV)/bin/activate"

.PHONY: clean
clean:
ifdef PIPENV_ACTIVE
	$(error Cannot clean the environment, if one is already active. 'exit' first...)
endif
	@echo
	@echo "==> Cleaning working directory..."
	@find . -name '*.egg-info' | xargs rm -rf
	@rm -rf __pycache__ .pytest_cache

.PHONY: install-git-hooks
install-git-hooks:
	@echo "==> Installing all git hooks..."
	find .git/hooks -type l -exec rm {} \;
	find .githooks -type f -exec ln -sf ../../{} .git/hooks/ \;

.PHONY: lint
lint:
	@echo
	@echo "==> Formatting code..."
	autopep8 --in-place --aggressive --recursive $(SOURCE_CODE)

	@echo
	@echo "==> Linting code..."
	pylint -j 4 --rcfile=".pylintrc" $(SOURCE_CODE)

	@echo
	@echo "==> Checking code style..."
	flake8 $(SOURCE_CODE)

	@echo
	@echo "==> Checking type hints..."
	mypy $(SOURCE_CODE)

.PHONY: test
test:
	@echo "==> Running tests..."
	@pytest $(SOURCE_CODE)

.PHONY: upgrade-deps
upgrade-deps:
ifndef VIRTUAL_ENV
	$(error Please activate a virtualenv first)
endif
ifeq (,$(shell command -v pip-upgrade))
	@echo
	@echo "==> Installing PIP upgrader"
	@pip install pip-upgrader
endif
	@echo
	@echo "==> Upgrading dependencies"
	@echo "==> You will be prompted for which dependencies to update"
	@echo "==> Please ensure you have activated your virtualenv, as the upgraded deps will be installed"
	@pip-upgrade

.PHONY: usage
usage:
	@echo "Usage:"
	@echo "clean: Removes build artifacts from the current working directory"
	@echo "install-git-hooks: Installs git hooks in the current working directory"
	@echo "lint: Lints and formats the source code"
	@echo "test: Runs all tests"
	@echo "upgrade-deps: Upgrades all dependencies"
	@echo "venv: Installs all dependencies in the current virtualenv"
	@echo

.PHONY: venv
venv:
ifndef VIRTUAL_ENV
	$(error Please activate a virtualenv first)
endif
	@echo
	@echo "==> Updating all dependencies..."
	python3 -m pip install --upgrade pip==$(PIP_VERSION)
	python3 -m pip install -r requirements/prod.txt
	python3 -m pip install -r requirements/dev.txt
	python3 -m pip install -e .

.PHONY: venv-init
venv-init:
ifdef VIRTUAL_ENV
	$(error A virtualenv is already active; deactivate it to proceed)
endif
	@echo
	echo "==> Initializing a virtual env..."
	python3 -m venv $(VENV)
	(. $(VENV)/bin/activate; $(MAKE) venv)
