%======================================================================
% Printing settings
h=figure(1);
set(h,'PaperUnits','inches')
set(h,'PaperOrientation','portrait');
set(h,'PaperSize',[TEXREPORT_GRAPH_HEIGHT,TEXREPORT_GRAPH_WIDTH])
set(h,'PaperPosition',[0,0,TEXREPORT_GRAPH_WIDTH,TEXREPORT_GRAPH_HEIGHT])

FN = findall(h,'-property','FontName');
set(FN,'FontName','/usr/share/fonts/dejavu/DejaVuSerifCondensed.ttf');
FS = findall(h,'-property','FontSize');
set(FS,'FontSize',TEXREPORT_GRAPH_FONTSIZE);

%======================================================================
% Do not modify below, since the scripts depend the settings
print(h, '-depslatex', '-color', 'graph.eps');
