# Makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
PAPER         =
BUILDDIR      = _build

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .
# the i18n builder cannot share the environment and doctrees with the others
PODIR         = po
I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .
LANGS = 

.PHONY: help clean html dirhtml singlehtml pickle json htmlhelp qthelp devhelp epub latex latexpdf text man changes linkcheck doctest gettext locale

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  html       to make standalone HTML files"
	@echo "  dirhtml    to make HTML files named index.html in directories"
	@echo "  singlehtml to make a single large HTML file"
	@echo "  pickle     to make pickle files"
	@echo "  json       to make JSON files"
	@echo "  htmlhelp   to make HTML files and a HTML help project"
	@echo "  qthelp     to make HTML files and a qthelp project"
	@echo "  devhelp    to make HTML files and a Devhelp project"
	@echo "  epub       to make an epub"
	@echo "  latex      to make LaTeX files, you can set PAPER=a4 or PAPER=letter"
	@echo "  latexpdf   to make LaTeX files and run them through pdflatex"
	@echo "  text       to make text files"
	@echo "  man        to make manual pages"
	@echo "  texinfo    to make Texinfo files"
	@echo "  info       to make Texinfo files and run them through makeinfo"
	@echo "  gettext    to (re)generate the .pot file using sphinx gettext"
	@echo "  locale     to compile .mo files from the .po files."
	@echo "  changes    to make an overview of all changed/added/deprecated items"
	@echo "  linkcheck  to check all external links for integrity"
	@echo "  doctest    to run all doctests embedded in the documentation (if enabled)"

clean:
	-rm -rf $(BUILDDIR)/* $(PODIR)/.doctrees \
	$(foreach lang,$(LANGS),$(PODIR)/$(lang)/)

html: $(foreach lang,$(LANGS),html-$(lang))
	# Always build an English version, even if there are no .po files.
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $(BUILDDIR)/html
	mv $(BUILDDIR)/html/ubuntu-packaging-guide/*html $(BUILDDIR)/html/
	mv $(BUILDDIR)/html/_sources/ubuntu-packaging-guide/*.txt $(BUILDDIR)/html/_sources/
	rm -r $(BUILDDIR)/html/_sources/ubuntu-packaging-guide/ $(BUILDDIR)/html/ubuntu-packaging-guide/
	sed -i 's/href="..\//href=".\//g' $(BUILDDIR)/html/*html
	sed -i 's/src="..\/_static/src=".\/_static/g' $(BUILDDIR)/html/*html
	sed -i 's/..\/_images/.\/_images/g' $(BUILDDIR)/html/*html
	sed -i 's/ubuntu-packaging-guide\///g' $(BUILDDIR)/html/*html
	sed -i 's/ubuntu-packaging-guide\///g' $(BUILDDIR)/html/searchindex.js
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html"
html-%: locale
	$(SPHINXBUILD) -Dlanguage=$* -b html $(ALLSPHINXOPTS) $(BUILDDIR)/html/$*
	mv $(BUILDDIR)/html/$*/ubuntu-packaging-guide/*html $(BUILDDIR)/html/$*
	mv $(BUILDDIR)/html/$*/_sources/ubuntu-packaging-guide/*.txt $(BUILDDIR)/html/$*/_sources/
	rm -r $(BUILDDIR)/html/$*/_sources/ubuntu-packaging-guide/ $(BUILDDIR)/html/$*/ubuntu-packaging-guide/
	sed -i 's/href="..\//href=".\//g' $(BUILDDIR)/html/$*/*html
	sed -i 's/src="..\/_static/src=".\/_static/g' $(BUILDDIR)/html/$*/*html
	sed -i 's/..\/_images/.\/_images/g' $(BUILDDIR)/html/$*/*html
	sed -i 's/ubuntu-packaging-guide\///g' $(BUILDDIR)/html/$*/*html
	sed -i 's/ubuntu-packaging-guide\///g' $(BUILDDIR)/html/$*/searchindex.js
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html/$*."

dirhtml: $(foreach lang,$(LANGS),dirhtml-$(lang))
	$(SPHINXBUILD) -b dirhtml $(ALLSPHINXOPTS) $(BUILDDIR)/dirhtml/en
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/dirhtml/en"
dirhtml-%: locale
	$(SPHINXBUILD) -Dlanguage=$* -b dirhtml $(ALLSPHINXOPTS) $(BUILDDIR)/dirhtml/$*
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/dirhtml/$*."

singlehtml: $(foreach lang,$(LANGS),singlehtml-$(lang))
	$(SPHINXBUILD) -b singlehtml $(ALLSPHINXOPTS) $(BUILDDIR)/singlehtml
	mv $(BUILDDIR)/singlehtml/ubuntu-packaging-guide/*html  $(BUILDDIR)/singlehtml
	sed -i 's/href="..\//href=".\//g' $(BUILDDIR)/singlehtml/index.html
	sed -i 's/ubuntu-packaging-guide\/index/index/g' $(BUILDDIR)/singlehtml/index.html
	sed -i 's/..\/..\/_images/.\/_images/g' $(BUILDDIR)/singlehtml/index.html
	sed -i 's/src="..\/_static/src=".\/_static/g' $(BUILDDIR)/singlehtml/index.html
	@echo
	@echo "Build finished. The HTML page is in $(BUILDDIR)/singlehtml"
singlehtml-%: locale
	$(SPHINXBUILD) -Dlanguage=$* -b singlehtml $(ALLSPHINXOPTS) $(BUILDDIR)/singlehtml/$*
	mv $(BUILDDIR)/singlehtml/$*/ubuntu-packaging-guide/*html  $(BUILDDIR)/singlehtml/$*
	sed -i 's/href="..\//href=".\//g' $(BUILDDIR)/singlehtml/$*/index.html
	sed -i 's/ubuntu-packaging-guide\/index/index/g' $(BUILDDIR)/singlehtml/$*/index.html
	sed -i 's/..\/..\/_images/.\/_images/g' $(BUILDDIR)/singlehtml/$*/index.html
	@echo
	@echo "Build finished. The HTML page is in $(BUILDDIR)/singlehtml/$*."

pickle:
	$(SPHINXBUILD) -b pickle $(ALLSPHINXOPTS) $(BUILDDIR)/pickle
	@echo
	@echo "Build finished; now you can process the pickle files."

json:
	$(SPHINXBUILD) -b json $(ALLSPHINXOPTS) $(BUILDDIR)/json
	@echo
	@echo "Build finished; now you can process the JSON files."

htmlhelp:
	$(SPHINXBUILD) -b htmlhelp $(ALLSPHINXOPTS) $(BUILDDIR)/htmlhelp
	@echo
	@echo "Build finished; now you can run HTML Help Workshop with the" \
	      ".hhp project file in $(BUILDDIR)/htmlhelp."

qthelp:
	$(SPHINXBUILD) -b qthelp $(ALLSPHINXOPTS) $(BUILDDIR)/qthelp
	@echo
	@echo "Build finished; now you can run "qcollectiongenerator" with the" \
	      ".qhcp project file in $(BUILDDIR)/qthelp, like this:"
	@echo "# qcollectiongenerator $(BUILDDIR)/qthelp/ubuntu-packaging-guide.qhcp"
	@echo "To view the help file:"
	@echo "# assistant -collectionFile $(BUILDDIR)/qthelp/ubuntu-packaging-guide.qhc"

devhelp:
	$(SPHINXBUILD) -b devhelp $(ALLSPHINXOPTS) $(BUILDDIR)/devhelp
	@echo
	@echo "Build finished."
	@echo "To view the help file:"
	@echo "# mkdir -p $$HOME/.local/share/devhelp/ubuntu-packaging-guide"
	@echo "# ln -s $(BUILDDIR)/devhelp $$HOME/.local/share/devhelp/ubuntu-packaging-guide"
	@echo "# devhelp"

epub: $(foreach lang,$(LANGS),epub-$(lang))
	$(SPHINXBUILD) -b epub $(ALLSPHINXOPTS) $(BUILDDIR)/epub
	@echo
	@echo "Build finished. The epub file is in $(BUILDDIR)/epub"
epub-%: locale
	$(SPHINXBUILD) -Dlanguage=$* -b epub $(ALLSPHINXOPTS) $(BUILDDIR)/epub/$*
	@echo
	@echo "Build finished. The epub file is in $(BUILDDIR)/epub/$*."

latex: $(foreach lang,$(LANGS),latex-$(lang))
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex
	@echo
	@echo "Build finished; the LaTeX files are in is in $(BUILDDIR)/epub/en"
	@echo "Run \`make' in that directory to run these through (pdf)latex" \
	      "(use \`make latexpdf' here to do that automatically)."
latex-%: locale
	$(SPHINXBUILD) -Dlanguage=$* -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex/$*
	@echo
	@echo "Build finished; the LaTeX files are in $(BUILDDIR)/latex/$*."
	@echo "Run \`make' in that directory to run these through (pdf)latex" \
	      "(use \`make latexpdf' here to do that automatically)."

latexpdf: $(foreach lang,$(LANGS),latexpdf-$(lang))
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex
	@echo "Running LaTeX files through pdflatex..."
	make -C $(BUILDDIR)/latex all-pdf
	mkdir -p $(BUILDDIR)/pdf; cp $(BUILDDIR)/latex/*pdf $(BUILDDIR)/pdf
	@echo "Build finished; the PDF files are in $(BUILDDIR)/pdf"
latexpdf-%: locale
	$(SPHINXBUILD) -Dlanguage=$* -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex/$*
	@echo "Running LaTeX files through pdflatex..."
	make -C $(BUILDDIR)/latex/$* all-pdf
	mkdir -p $(BUILDDIR)/pdf/$*; cp $(BUILDDIR)/latex/$*/*pdf $(BUILDDIR)/pdf/$*
	@echo "pdflatex finished; the PDF files are in $(BUILDDIR)/pdf/$*."

text: $(foreach lang,$(LANGS),text-$(lang))
	$(SPHINXBUILD) -b text $(ALLSPHINXOPTS) $(BUILDDIR)/text/en
	@echo
	@echo "Build finished. The text pages are in $(BUILDDIR)/text/en"
text-%: locale
	$(SPHINXBUILD) -Dlanguage=$* -b text $(ALLSPHINXOPTS) $(BUILDDIR)/text/$*
	@echo
	@echo "Build finished. The text files are in $(BUILDDIR)/text/$*."

man: $(foreach lang,$(LANGS),man-$(lang))
	$(SPHINXBUILD) -b man $(ALLSPHINXOPTS) $(BUILDDIR)/man/en
	@echo
	@echo "Build finished. The manual pages are in $(BUILDDIR)/man/en"
man-%: locale
	$(SPHINXBUILD) -Dlanguage=$* -b man $(ALLSPHINXOPTS) $(BUILDDIR)/man/$*
	@echo
	@echo "Build finished. The manual pages are in $(BUILDDIR)/man/$*."

texinfo: $(foreach lang,$(LANGS),texinfo-$(lang))
	$(SPHINXBUILD) -b texinfo $(ALLSPHINXOPTS) $(BUILDDIR)/texinfo/en
	@echo
	@echo "Build finished. The Texinfo files are in $(BUILDDIR)/texinfo/en."
	@echo "Run \`make' in that directory to run these through makeinfo" \
	      "(use \`make info' here to do that automatically)."
texinfo-%: locale
	$(SPHINXBUILD) -Dlanguage=$* -b texinfo $(ALLSPHINXOPTS) $(BUILDDIR)/texinfo/$*
	@echo
	@echo "Build finished. The Texinfo files are in $(BUILDDIR)/texinfo/$*."
	@echo "Run \`make' in that directory to run these through makeinfo" \
	      "(use \`make info' here to do that automatically)."

info: $(foreach lang,$(LANGS),info-$(lang))
	$(SPHINXBUILD) -b texinfo $(ALLSPHINXOPTS) $(BUILDDIR)/texinfo/en
	@echo "Running Texinfo files through makeinfo..."
	make -C $(BUILDDIR)/texinfo/en info
	@echo "makeinfo finished; the Info files are in $(BUILDDIR)/texinfo/en."
info-%: locale
	$(SPHINXBUILD) -Dlanguage=$* -b texinfo $(ALLSPHINXOPTS) $(BUILDDIR)/texinfo/$*
	@echo "Running Texinfo files through makeinfo..."
	make -C $(BUILDDIR)/texinfo/$* info
	@echo "makeinfo finished; the Info files are in $(BUILDDIR)/texinfo/$*."

gettext:
	$(SPHINXBUILD) -b gettext $(I18NSPHINXOPTS) $(PODIR)/
	@echo
	@echo "Build finished. The message catalogs are in $(PODIR)/."

changes:
	$(SPHINXBUILD) -b changes $(ALLSPHINXOPTS) $(BUILDDIR)/changes
	@echo
	@echo "The overview file is in $(BUILDDIR)/changes."

linkcheck:
	$(SPHINXBUILD) -b linkcheck $(ALLSPHINXOPTS) $(BUILDDIR)/linkcheck
	@echo
	@echo "Link check complete; look for any errors in the above output " \
	      "or in $(BUILDDIR)/linkcheck/output.txt."

doctest:
	$(SPHINXBUILD) -b doctest $(ALLSPHINXOPTS) $(BUILDDIR)/doctest
	@echo "Testing of doctests in the sources finished, look at the " \
	      "results in $(BUILDDIR)/doctest/output.txt."

locale: $(foreach lang,$(LANGS),locale-$(lang))
locale-%:
	@echo "Compiling .mo files in $(PODIR)/$*/LC_MESSAGES"
	mkdir -p $(PODIR)/$*/LC_MESSAGES
	msgfmt po/$*.po -o po/$*/LC_MESSAGES/ubuntu-packaging-guide.mo

