::clean
del /s /q main.aux main.bcf main.blg main.ilg main.log main.out main.pdf main.ptc main.run.xml main.toc

::comp
pdflatex main
makeindex main.idx -s StyleInd.ist
biber main
pdflatex main
pdflatex main