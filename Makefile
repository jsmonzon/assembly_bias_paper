# Local build of the paper. Overleaf ignores this file.
#   make            build build/main.pdf
#   make diff       build build/diff.pdf: changes since the last commit, marked up
#   make diff REV=HEAD~3   compare against an older commit instead
#   make clean      remove build/

TEX  = main
REV ?= HEAD
LATEXMK = latexmk -pdf -f -interaction=nonstopmode -file-line-error

all:
	$(LATEXMK) -outdir=build $(TEX).tex

diff:
	mkdir -p build
	git show $(REV):$(TEX).tex > build/old.tex
	latexdiff build/old.tex $(TEX).tex > build/diff.tex
	cd build && TEXINPUTS=..: BIBINPUTS=..: BSTINPUTS=..: $(LATEXMK) diff.tex

clean:
	rm -rf build

.PHONY: all diff clean
