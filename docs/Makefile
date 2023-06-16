# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line or the environment
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     ?= .
BUILDDIR      ?= _build
VENVDIR       ?= .sphinx/venv
IN_VENV       ?= . $(VENVDIR)/bin/activate


# Put it first so that "make" without argument is like "make help".
help:
	@echo "The following make targets are available:"
	@echo "* install   -- set up a virtual-env to work on documentation"
	@echo "* run       -- watch, build and serve the documentation"
	@echo "* html      -- build HTML output under $(BUILDDIR)/html"
	@echo "* serve     -- serve HTML output from $(BUILDDIR)/html"
	@echo "* epub      -- build epub output under $(BUILDDIR)/epub"
	@echo "* pdf       -- build pdf output under $(BUILDDIR)/pdf"
	@echo "* clean-doc -- clean built doc files"
	@echo "* clean     -- clean full environment"
	@echo "* spelling  -- check spelling"
	@echo "* linkcheck -- check external links"
	@echo "* woke      -- check inclusive language"
	@echo "-------------------------------------------"

install:
	@echo "... setting up virtualenv"
	python3 -m venv $(VENVDIR)
	$(IN_VENV); pip install --upgrade -r .sphinx/requirements.txt

run:
	$(IN_VENV); sphinx-autobuild -b dirhtml "$(SOURCEDIR)" "$(BUILDDIR)"/html

html:
	$(IN_VENV); $(SPHINXBUILD) -b dirhtml "$(SOURCEDIR)" "$(BUILDDIR)"/html

epub:
	$(IN_VENV); $(SPHINXBUILD) -b epub "$(SOURCEDIR)" "$(BUILDDIR)"/epub

pdf:
	$(IN_VENV); $(SPHINXBUILD) -b latex "$(SOURCEDIR)" "$(BUILDDIR)"/pdf
	$(IN_VENV); $(MAKE) -C "$(BUILDDIR)"/pdf all-pdf

serve:
	python3 -m http.server 8000 -d "$(BUILDDIR)"/html

clean: clean-doc
	rm -rf "$(VENVDIR)"

clean-doc:
	git clean -fx "$(BUILDDIR)"

distclean:
	rm -rf "$(BUILDDIR)"
	rm -rf "$(VENVDIR)"

spelling: html
	$(IN_VENV); python3 -m pyspelling -c .sphinx/spellingcheck.yaml

linkcheck: html epub
	$(IN_VENV); $(SPHINXBUILD) -b linkcheck "$(SOURCEDIR)" "$(BUILDDIR)"/html
	$(IN_VENV); $(SPHINXBUILD) -b linkcheck "$(SOURCEDIR)" "$(BUILDDIR)"/epub

woke:
	type woke >/dev/null 2>&1 || { snap install woke; exit 1; }
	woke $(find -name "*.rst") -c https://github.com/canonical-web-and-design/Inclusive-naming/raw/main/config.yml

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	$(IN_VENV); $(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
