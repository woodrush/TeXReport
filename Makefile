TARGET = report
GRAPHGENDIR = ./GraphGen
FIGURESDIR  = ./Figures
TABLEGENDIR = ./TableGen
SUBTARGETS = .graph .fig .table $(wildcard ./tables/*.tex) $(wildcard ./graphs/*.tex) $(wildcard ./*.tex) 

all:
	make $(TARGET).pdf
	open -a Preview $(TARGET).pdf

#======================================================================
$(TARGET).pdf: .$(TARGET).dvi
	dvipdfmx -o $(TARGET).pdf $<

.$(TARGET).dvi: $(SUBTARGETS)
	platex $(TARGET).tex;\
	if [ "$$?" != "0" ]; then rm -rf $(TARGET).dvi; make hide; exit 1; fi;
	platex $(TARGET).tex
	@make hide

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
	for i in $(GRAPHGENDIR) $(FIGURESDIR) $(TABLEGENDIR); do [ ! -f $$i/* ] || touch $$i/*; done
	for i in aux dvi log idx; do [ ! -f .$(TARGET).$$i ] || rm -rf .$(TARGET).$$i; done
	for i in fig graph table; do [ ! -f .$$i ] || rm -rf .$$i; done
	[ ! -f texput.log ] || rm -rf texput.log

hide:
	for i in aux dvi log idx; do [ ! -f $(TARGET).$$i ] || mv $(TARGET).$$i .$(TARGET).$$i; done
