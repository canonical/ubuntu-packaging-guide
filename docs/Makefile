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
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

install:
	@echo "... setting up virtualenv"
	python3 -m venv $(VENVDIR)
	$(IN_VENV); pip install --upgrade -r .sphinx/requirements.txt

	@echo "---------------------------------------------------------------"
	@echo "* watch, build and serve the documentation: make run"
	@echo "* only build: make html"
	@echo "* only epub: make epub"
	@echo "* only serve: make serve"
	@echo "* clean built doc files: make clean-doc"
	@echo "* clean full environment: make clean"
	@echo "* check spelling: make spelling"
	@echo "* check links: make linkcheck"
	@echo "* check inclusive language: make woke"
	@echo "---------------------------------------------------------------"
run:
	$(IN_VENV); sphinx-autobuild -c . -b dirhtml "$(SOURCEDIR)" "$(BUILDDIR)"

html:
	$(IN_VENV); $(SPHINXBUILD) -c . -b dirhtml "$(SOURCEDIR)" "$(BUILDDIR)"

epub:
	$(IN_VENV); $(SPHINXBUILD) -c . -b epub "$(SOURCEDIR)" "$(BUILDDIR)"

serve:
	python3 -m http.server 8000 -d "$(BUILDDIR)"

clean: clean-doc
	rm -rf "$(VENVDIR)"

clean-doc:
	git clean -fx "$(BUILDDIR)"

spelling: html
	$(IN_VENV); python3 -m pyspelling -c .sphinx/spellingcheck.yaml

linkcheck:
	$(IN_VENV); $(SPHINXBUILD) -c . -b linkcheck  "$(SOURCEDIR)" "$(BUILDDIR)"

woke:
	type woke >/dev/null 2>&1 || { snap install woke; exit 1; }
	woke $(find -name "*.rst") -c https://github.com/canonical-web-and-design/Inclusive-naming/raw/main/config.yml

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	$(IN_VENV); $(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
