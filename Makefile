clean:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

run: clean
	@gunicorn orders:app --bind localhost:8080 --worker-class aiohttp.worker.GunicornUVLoopWebWorker -e SIMPLE_SETTINGS=orders.settings.development

install-test:
	@pip install -r requirements/test.txt

install-development:
	@pip install -r requirements/development.txt

test: clean
	@SIMPLE_SETTINGS=orders.settings.test py.test orders

test-matching: clean
	@SIMPLE_SETTINGS=orders.settings.test pytest -rxs -k${Q} orders

test-coverage:
	@SIMPLE_SETTINGS=orders.settings.test pytest --cov=orders orders --cov-report term-missing

lint:
	@flake8
	@isort --check

lint-fix:
	@isort --apply

detect-outdated-dependencies:
	@sh -c 'output=$$(pip list --outdated); echo "$$output"; test -z "$$output"'

upgrade-outdated-dependencies:
	@pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U

release-patch: ## Create patch release
	SIMPLE_SETTINGS=orders.settings.test bump2version patch --dry-run --no-tag --no-commit --list | grep new_version= | sed -e 's/new_version=//' | xargs -n 1 towncrier --yes --version
	git commit -am 'Update CHANGELOG'
	bump2version patch

release-minor: ## Create minor release
	SIMPLE_SETTINGS=orders.settings.test bump2version minor --dry-run --no-tag --no-commit --list | grep new_version= | sed -e 's/new_version=//' | xargs -n 1 towncrier --yes --version
	git commit -am 'Update CHANGELOG'
	bump2version minor

release-major: ## Create major release
	SIMPLE_SETTINGS=orders.settings.test bump2version major --dry-run --no-tag --no-commit --list | grep new_version= | sed -e 's/new_version=//' | xargs -n 1 towncrier --yes --version
	git commit -am 'Update CHANGELOG'
	bump2version major
