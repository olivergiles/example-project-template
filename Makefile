install_requirements:
	@pip install -r requirements.txt


black:
	@black main/*.py

test:
	@coverage run -m pytest tests/*.py

install:
	@pip install . -U

clean:
	@rm -f */version.txt
	@rm -f .coverage
	@rm -fr */__pycache__ */*.pyc __pycache__
	@rm -fr build dist
	@rm -fr translating-the-law-*.dist-info
	@rm -fr translating-the-law.egg-info
