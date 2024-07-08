# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?= -c . -d .sphinx/.doctrees
SPHINXBUILD   ?= sphinx-build
SPHINXDIR     = .sphinx
SOURCEDIR     = .
BUILDDIR      = _build
VENVDIR       = $(SPHINXDIR)/venv
PA11Y         = $(SPHINXDIR)/node_modules/pa11y/bin/pa11y.js
VENV          = $(VENVDIR)/bin/activate
SHELL = /usr/bin/bash

.PHONY: full-help help distro-info-install woke-install pa11y-install install \
        run html epub serve clean clean-doc spelling linkcheck woke pa11y \
		pdf pdf-prep pdf-prep-force Makefile

# Put it first so that "make" without argument is like "make help".
help:
	@echo "\n" \
        "--------------------------------------------------------------- \n" \
        "* watch, build and serve the documentation: make run \n" \
        "* only build: make html \n" \
        "* only serve: make serve \n" \
        "* clean built doc files: make clean-doc \n" \
        "* clean full environment: make clean \n" \
        "* check links: make linkcheck \n" \
        "* check spelling: make spelling \n" \
        "* check inclusive language: make woke \n" \
        "* check accessibility: make pa11y \n" \
        "* build PDF: make pdf \n" \
        "* force install packages for PDF generation: make pdf-prep-force \n" \
        "* other possible targets: make <press TAB twice> \n" \
        "--------------------------------------------------------------- \n"

full-help: $(VENVDIR)
	@. $(VENV); $(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
	@echo "\n\033[1;31mNOTE: This help texts shows unsupported targets!\033[0m"
	@echo "Run 'make help' to see supported targets."
	
$(SPHINXDIR)/requirements.txt: distro-info-install
	python3 build_requirements.py

# If requirements are updated, venv should be rebuilt and timestamped.
$(VENVDIR): $(SPHINXDIR)/requirements.txt
	@echo "... setting up virtualenv"
	python3 -m venv --system-site-packages $(VENVDIR)
	. $(VENV); pip install --require-virtualenv \
	    --upgrade -r $(SPHINXDIR)/requirements.txt \
            --log $(VENVDIR)/pip_install.log
	@test ! -f $(VENVDIR)/pip_list.txt || \
            mv $(VENVDIR)/pip_list.txt $(VENVDIR)/pip_list.txt.bak
	@. $(VENV); pip list --local --format=freeze > $(VENVDIR)/pip_list.txt
	@touch $(VENVDIR)

distro-info-install:
	if (dpkg --status python3-distro-info | grep installed); then \
		echo "Skip installing python3-distro-info, because it is already installed."; \
	else \
		echo "Installing python3-distro-info..."; \
		sudo apt-get update; \
		sudo apt-get install --assume-yes python3-distro-info; \
	fi
	
woke-install:
	@type woke >/dev/null 2>&1 || \
            { echo "Installing \"woke\" snap... \n"; sudo snap install woke; }

pa11y-install:
	@type $(PA11Y) >/dev/null 2>&1 || { \
			echo "Installing \"pa11y\" from npm... \n"; \
			mkdir -p $(SPHINXDIR)/node_modules/ ; \
			npm install --prefix $(SPHINXDIR) pa11y; \
		}

install: $(VENVDIR) woke-install

run: install
	. $(VENV); sphinx-autobuild -b dirhtml "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS)

# Doesn't depend on $(BUILDDIR) to rebuild properly at every run.
html: install
	. $(VENV); $(SPHINXBUILD) -b dirhtml "$(SOURCEDIR)" "$(BUILDDIR)" -w .sphinx/warnings.txt $(SPHINXOPTS)

epub: install
	. $(VENV); $(SPHINXBUILD) -b epub "$(SOURCEDIR)" "$(BUILDDIR)" -w .sphinx/warnings.txt $(SPHINXOPTS)

serve: html
	cd "$(BUILDDIR)"; python3 -m http.server 8000

clean: clean-doc
	@test ! -e "$(VENVDIR)" -o -d "$(VENVDIR)" -a "$(abspath $(VENVDIR))" != "$(VENVDIR)"
	rm -rf $(VENVDIR)
	rm -f .sphinx/requirements.txt

clean-doc:
	git clean -fx "$(BUILDDIR)"
	rm -rf .sphinx/.doctrees

spelling: html
	. $(VENV) ; python3 -m pyspelling -c .sphinx/spellingcheck.yaml -j $(shell nproc)

linkcheck: install
	. $(VENV) ; $(SPHINXBUILD) -b linkcheck "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS)

woke: woke-install
	woke *.rst **/*.rst --exit-1-on-failure \
	    -c https://github.com/canonical/Inclusive-naming/raw/main/config.yml

pa11y: pa11y-install html
	find $(BUILDDIR) -name *.html -print0 | xargs -n 1 -0 $(PA11Y)

# Standard PDF generation checks for system packages and provides context if not found

pdf-prep: install
	@. $(VENV); (dpkg-query -W -f='$${Status}' latexmk 2>/dev/null | grep -c "ok installed" >/dev/null && echo "Package latexmk is installed") || (echo "PDF generation requires the installation of the following packages: latexmk fonts-freefont-otf fonts-ibm-plex texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-font-utils texlive-lang-cjk texlive-xetex plantuml xindy tex-gyre dvipng" && echo "" && echo "make pdf-prep-force will install these packages" && echo "" && echo "Please be aware these packages will be installed to your system" && false)
	@. $(VENV); (dpkg-query -W -f='$${Status}' fonts-freefont-otf 2>/dev/null | grep -c "ok installed" >/dev/null && echo "Package fonts-freefont-otf is installed") || (echo "PDF generation requires the installation of the following packages: latexmk fonts-freefont-otf fonts-ibm-plex texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-font-utils texlive-lang-cjk texlive-xetex plantuml xindy tex-gyre dvipng" && echo "" && echo "make pdf-prep-force will install these packages" && echo "" && echo "Please be aware these packages will be installed to your system" && false)
	@. $(VENV); (dpkg-query -W -f='$${Status}' fonts-ibm-plex 2>/dev/null | grep -c "ok installed" >/dev/null && echo "Package fonts-ibm-plex is installed") || (echo "PDF generation requires the installation of the following packages: latexmk fonts-freefont-otf fonts-ibm-plex texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-font-utils texlive-lang-cjk texlive-xetex plantuml xindy tex-gyre dvipng" && echo "" && echo "make pdf-prep-force will install these packages" && echo "" && echo "Please be aware these packages will be installed to your system" && false)
	@. $(VENV); (dpkg-query -W -f='$${Status}' texlive-latex-recommended 2>/dev/null | grep -c "ok installed" >/dev/null && echo "Package texlive-latex-recommended is installed") || (echo "PDF generation requires the installation of the following packages: latexmk fonts-freefont-otf fonts-ibm-plex texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-font-utils texlive-lang-cjk texlive-xetex plantuml xindy tex-gyre dvipng" && echo "" && echo "make pdf-prep-force will install these packages" && echo "" && echo "Please be aware these packages will be installed to your system" && false)
	@. $(VENV); (dpkg-query -W -f='$${Status}' texlive-latex-extra 2>/dev/null | grep -c "ok installed" >/dev/null && echo "Package texlive-latex-extra is installed") || (echo "PDF generation requires the installation of the following packages: latexmk fonts-freefont-otf fonts-ibm-plex texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-font-utils texlive-lang-cjk texlive-xetex plantuml xindy tex-gyre dvipng" && echo "" && echo "make pdf-prep-force will install these packages" && echo "" && echo "Please be aware these packages will be installed to your system" && false)
	@. $(VENV); (dpkg-query -W -f='$${Status}' texlive-fonts-recommended 2>/dev/null | grep -c "ok installed" >/dev/null && echo "Package texlive-fonts-recommended is installed") || (echo "PDF generation requires the installation of the following packages: latexmk fonts-freefont-otf fonts-ibm-plex texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-font-utils texlive-lang-cjk texlive-xetex plantuml xindy tex-gyre dvipng" && echo "" && echo "make pdf-prep-force will install these packages" && echo "" && echo "Please be aware these packages will be installed to your system" && false)
	@. $(VENV); (dpkg-query -W -f='$${Status}' texlive-font-utils 2>/dev/null | grep -c "ok installed" >/dev/null && echo "Package texlive-font-utils is installed") || (echo "PDF generation requires the installation of the following packages: latexmk fonts-freefont-otf fonts-ibm-plex texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-font-utils texlive-lang-cjk texlive-xetex plantuml xindy tex-gyre dvipng" && echo "" && echo "make pdf-prep-force will install these packages" && echo "" && echo "Please be aware these packages will be installed to your system" && false)
	@. $(VENV); (dpkg-query -W -f='$${Status}' texlive-lang-cjk 2>/dev/null | grep -c "ok installed" >/dev/null && echo "Package texlive-lang-cjk is installed") || (echo "PDF generation requires the installation of the following packages: latexmk fonts-freefont-otf fonts-ibm-plex texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-font-utils texlive-lang-cjk texlive-xetex plantuml xindy tex-gyre dvipng" && echo "" && echo "make pdf-prep-force will install these packages" && echo "" && echo "Please be aware these packages will be installed to your system" && false)
	@. $(VENV); (dpkg-query -W -f='$${Status}' texlive-xetex 2>/dev/null | grep -c "ok installed" >/dev/null && echo "Package texlive-xetex is installed") || (echo "PDF generation requires the installation of the following packages: latexmk fonts-freefont-otf fonts-ibm-plex texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-font-utils texlive-lang-cjk texlive-xetex plantuml xindy tex-gyre dvipng" && echo "" && echo "make pdf-prep-force will install these packages" && echo "" && echo "Please be aware these packages will be installed to your system" && false)
	@. $(VENV); (dpkg-query -W -f='$${Status}' plantuml 2>/dev/null | grep -c "ok installed" >/dev/null && echo "Package plantuml is installed") || (echo "PDF generation requires the installation of the following packages: latexmk fonts-freefont-otf fonts-ibm-plex texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-font-utils texlive-lang-cjk texlive-xetex plantuml xindy tex-gyre dvipng" && echo "" && echo "make pdf-prep-force will install these packages" && echo "" && echo "Please be aware these packages will be installed to your system" && false)
	@. $(VENV); (dpkg-query -W -f='$${Status}' xindy 2>/dev/null | grep -c "ok installed" >/dev/null && echo "Package xindy is installed") || (echo "PDF generation requires the installation of the following packages: latexmk fonts-freefont-otf fonts-ibm-plex texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-font-utils texlive-lang-cjk texlive-xetex plantuml xindy tex-gyre dvipng" && echo "" && echo "make pdf-prep-force will install these packages" && echo "" && echo "Please be aware these packages will be installed to your system" && false)
	@. $(VENV); (dpkg-query -W -f='$${Status}' tex-gyre 2>/dev/null | grep -c "ok installed" >/dev/null && echo "Package tex-gyre is installed") || (echo "PDF generation requires the installation of the following packages: latexmk fonts-freefont-otf fonts-ibm-plex texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-font-utils texlive-lang-cjk texlive-xetex plantuml xindy tex-gyre dvipng" && echo "" && echo "make pdf-prep-force will install these packages" && echo "" && echo "Please be aware these packages will be installed to your system" && false)
	@. $(VENV); (dpkg-query -W -f='$${Status}' dvipng 2>/dev/null | grep -c "ok installed" >/dev/null && echo "Package dvipng is installed") || (echo "PDF generation requires the installation of the following packages: latexmk fonts-freefont-otf fonts-ibm-plex texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-font-utils texlive-lang-cjk texlive-xetex plantuml xindy tex-gyre dvipng" && echo "" && echo "make pdf-prep-force will install these packages" && echo "" && echo "Please be aware these packages will be installed to your system" && false)

# Entrypoint to install system packages, separate from usual workflow due to permanence

pdf-prep-force:
	apt-get update
	apt-get install --no-install-recommends -y latexmk fonts-freefont-otf fonts-ibm-plex texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-font-utils texlive-lang-cjk texlive-xetex plantuml xindy tex-gyre dvipng \

pdf: pdf-prep
	@. $(VENV); sphinx-build -M latexpdf "$(SOURCEDIR)" "_build" $(SPHINXOPTS)
	@. $(VENV); find ./_build/latex -name "*.pdf" -exec mv -t ./ {} +
	@. $(VENV); rm -r _build

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	. $(VENV); $(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
