.PHONY: help
help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "check-manpages  check for manpage in types"
	@echo "lint            run shellcheck on types"
	@echo "check           run both type manpage checks and linting"

TYPEDIR=./type


check-manpages:
	./scripts/run-manpage-checks.sh

lint:
	./scripts/run-shellcheck.sh

check: check-manpages lint

clean:
	$(SPHINXC)
	rm -f docs/src/index.rst
	rm -rf docs/src/man7/
	rm -rf docs/src/__pycache__/
