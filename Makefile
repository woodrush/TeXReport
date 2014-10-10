TARGET = report
GRAPHGENDIR = ./GraphGen
FIGURESDIR  = ./Figures
TABLEGENDIR = ./TableGen
BIBTEXDIR = ./BibTeX
SUBTARGETS = $(wildcard ./tables/*.tex) $(wildcard ./graphs/*.tex) $(wildcard ./scripts/*.tex)
HIDDENTARGETS = .graph .fig .table .punc .bibtex
HIDEEXTENSIONS = aux dvi log idx bbl blg
REPLACEPUNC = 1

all:
	make $(TARGET).pdf
	open -a Preview $(TARGET).pdf

#======================================================================
$(TARGET).pdf: $(SUBTARGETS) $(HIDDENTARGETS)
	pdflatex $(TARGET).tex;\
	if [ "$$?" != "0" ]; then rm -rf $(TARGET).dvi; make hide; exit 1; fi;
	bibtex $(TARGET)
	pdflatex $(TARGET).tex;
	pdflatex $(TARGET).tex;
	@make hide

.bibtex: $(wildcard ./$(BIBTEXDIR)/*.bib)
	./scripts/grandbibtex.sh
	@touch .bibtex

.punc: $(wildcard ./*.tex)
	if [ $(REPLACEPUNC) != "" ]; then sed -i '' -e 's/、/，/' $?; fi
	if [ $(REPLACEPUNC) != "" ]; then sed -i '' -e 's/。/．/' $?; fi
	@touch .punc

.graph: $(wildcard ./$(GRAPHGENDIR)/*.m)
	if [ "$?" != "" ]; then for i in $?; do ./scripts/graph.sh $$i; done fi
	@touch .graph

.fig: $(wildcard $(FIGURESDIR)/*)
	if [ "$?" != "" ]; then for i in $?; do ./scripts/fig.sh $$i; done fi
	@touch .fig

.table: $(wildcard ./$(TABLEGENDIR)/*)
	if [ "$?" != "" ]; then for i in $?; do ./scripts/table.sh $$i; done fi
	@touch .table

#======================================================================
.PHONY: clean hide
clean:
	for i in $(GRAPHGENDIR) $(FIGURESDIR) $(TABLEGENDIR) $(BIBTEXDIR) ; do [ ! -f $$i/* ] || touch $$i/*; done
	for i in $(HIDEEXTENSIONS); do [ ! -f .$(TARGET).$$i ] || rm -rf .$(TARGET).$$i; done
	for i in $(HIDDENTARGETS); do [ ! -f .$$i ] || rm -rf $$i; done
	[ ! -f texput.log ] || rm -rf texput.log

hide:
	for i in $(HIDEEXTENSIONS); do [ ! -f $(TARGET).$$i ] || mv $(TARGET).$$i .$(TARGET).$$i; done
