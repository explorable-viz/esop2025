default: quick

quick:
	pdflatex main.tex

appendix:
	pdflatex appendix.tex

full:
	pdflatex main.tex
	biber main
	pdflatex main.tex
	pdflatex main.tex
