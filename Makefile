install_requirements:
	@pip install -r requirements.txt


black:
	@black main/*.py

test:
	@coverage run -m pytest tests/*.py

install:
	@pip install . -U
