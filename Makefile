.PHONY: help
help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "man             build only man user documentation"
	@echo "html            build only html user documentation"
	@echo "docs            build both man and html user documentation"
	@echo "check-manpages  check for manpage in types"
	@echo "lint            run shellcheck on types"
	@echo "check           run both type manpage checks and linting"
	@echo "clean           clean"

DOCS_SRC_DIR=./docs/src
TYPEDIR=./type

SPHINXM=make -C $(DOCS_SRC_DIR) man
SPHINXH=make -C $(DOCS_SRC_DIR) html
SPHINXC=make -C $(DOCS_SRC_DIR) clean

################################################################################
# Manpages
#
MAN7DSTDIR=$(DOCS_SRC_DIR)/man7

# Use shell / ls to get complete list - $(TYPEDIR)/*/man.rst does not work
# Using ls does not work if no file with given pattern exist, so use wildcard
MANTYPESRC=$(wildcard $(TYPEDIR)/*/man.rst)
MANTYPEPREFIX=$(subst $(TYPEDIR)/,$(MAN7DSTDIR)/cdist-type,$(MANTYPESRC))
MANTYPES=$(subst /man.rst,.rst,$(MANTYPEPREFIX))

# Link manpage: do not create man.html but correct named file
$(MAN7DSTDIR)/cdist-type%.rst: $(TYPEDIR)/%/man.rst
	mkdir -p $(MAN7DSTDIR)
	ln -sf "../../../$^" $@

DOCSINDEX=$(MAN7DSTDIR)/index.rst
DOCSINDEXH=$(DOCS_SRC_DIR)/index.rst.sh

$(DOCSINDEX): $(DOCSINDEXH)
	$(DOCSINDEXH)

# Manpages: .cdist Types
DOT_CDIST_PATH=${HOME}/.cdist
DOTMAN7DSTDIR=$(MAN7DSTDIR)
DOTTYPEDIR=$(DOT_CDIST_PATH)/type

# Link manpage: do not create man.html but correct named file
$(DOTMAN7DSTDIR)/cdist-type%.rst: $(DOTTYPEDIR)/%/man.rst
	ln -sf "$^" $@

man: $(MANTYPES) $(DOCSINDEX)
	$(SPHINXM)

html: $(MANTYPES) $(DOCSINDEX)
	$(SPHINXH)

docs: man html

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
