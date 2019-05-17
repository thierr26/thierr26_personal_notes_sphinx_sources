# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SPHINXPROJ    = PersonalNotes
SOURCEDIR     = source
BUILDDIR      = build

# Uncomment the next three lines to make "html" the default target and have the
# "html" build post-processed automatically.
html: Makefile
	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
	@./post_process_html build/html

# Uncomment the next two lines to enable the "htmlcheck" target (needs v.Nu
# installed in /usr/local/nu_html_checker, see
# https://validator.github.io/validator/#build-instructions).
htmlcheck: html
	@java -jar /usr/local/nu_html_checker/build/dist/vnu.jar build/html/*.html

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
