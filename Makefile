.PHONY: help install install-dev format lint test clean

help:
	@echo "Available commands:"
	@echo "  install     - Install production dependencies"
	@echo "  install-dev - Install development dependencies"
	@echo "  format      - Format code with black and isort"
	@echo "  lint        - Run all linters"
	@echo "  test        - Run tests"
	@echo "  clean       - Clean up cache files"

install:
	pip install -r requirements.txt

install-dev:
	pip install -r requirements.txt
	pip install -r requirements-dev.txt

format:
	@echo "Running black..."
	black .
	@echo "Running isort..."
	isort .

lint:
	@echo "Running flake8..."
	flake8 .
	@echo "Running mypy..."
	mypy .
	@echo "Running bandit..."
	bandit -r . -x tests/
	@echo "Running pylint..."
	pylint django_sample/

test:
	python manage.py test

clean:
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
