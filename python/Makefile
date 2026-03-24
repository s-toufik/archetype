venv:
	uv venv

install:
	uv sync

install_dev:
	uv sync --group dev

run:
	uv run uvicorn price.main:app --reload

test:
	uv run pytest

lint:
	uv run ruff check .

format:
	uv run ruff format .

git_init:
	git init
	git add --all
	git commit -m "init project"
	git checkout -b develop

build:
	rm -rf dist
	rm -rf src/*.egg-info
	uv build

publish:
	@echo "INFO: Make sure that UV_PUBLISH_TOKEN env variable is set"
	uv publish

publish_dev:
	UV_PUBLISH_TOKEN=$$UV_TEST_PUBLISH_TOKEN
	uv publish --publish-url https://test.pypi.org/legacy/