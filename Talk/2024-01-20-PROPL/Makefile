COMPILE = xelatex

default: abstract

abstract:
	$(COMPILE) $@
	bibtex $@
	$(COMPILE) $@
	$(COMPILE) $@
	rm -f *.aux *.dvi *.log *.bbl *.blg *.out
