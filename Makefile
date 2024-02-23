default: quick

quick:
	pdflatex main.tex

apdx:
	pdflatex apdx.tex

full:
	pdflatex main.tex
	bibtex main
	pdflatex main.tex
	pdflatex main.tex
