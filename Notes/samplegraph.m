% Write an octave script that writes a plot in figure 1.

function xdot = cevolution1(x, t)
    k_10 = 1;
    k_12 = 2.5;
    k_21 = 3;
    b_0 = 4;
    K = [5, 1, 1];
    L = [8;
         10;
         3;];
    k_r = 1/0.1600;
    r = 5;
    A = [-k_10-k_12,  k_12, b_0;
               k_21, -k_21,   0;
                  0,     0,   0;];
    B = [b_0;
           0;
           0;];

    C = [0, 1, 0];

    xdot(1:3) = (A-B*K)*x(1:3) + B*K*x(4:6) + B*k_r*r;
    xdot(4:6) = (A-L*C)*x(4:6);
endfunction

%======================================================================
% Plotting parameters
mintime = 0;
maxtime = 6;
delta_t = 0.001;

minx_y = -5;
maxx_y = 20;
maxx_u = 500;
h=figure(1);

%======================================================================
% Condition 1
%======================================================================

% Conditions
x_0 = [1;3;1;2;1;-0.5];
t = (mintime:delta_t:maxtime)';
x_out = lsode('cevolution1', x_0, t);
% subplot(121);

% Plot
	clf;
	plot(t,x_out(:,1),'-r','linewidth',3);
	hold on;
	plot(t,x_out(:,2),'-g','linewidth',3);
	plot(t,x_out(:,3),'-b','linewidth',3);
	plot(t,x_out(:,4),'r','linestyle','--','linewidth',3);
	plot(t,x_out(:,5),'g','linestyle','--','linewidth',3);
	plot(t,x_out(:,6),'b','linestyle','--','linewidth',3);
    hold off;

% EndPlot

xlabel('Time $t$\,(s)');
ylabel('Concentration (mol/L)');
axis([0 maxtime -1 6]);
legend({'$c_1$','$c_2$','$u_0$','$\tilde c_1$','$\tilde c_2$','$\tilde u_0$'},'location','east');


%======================================================================
% Printing settings
h=figure(1);
W = 5; H = 3;
set(h,'PaperUnits','inches')
set(h,'PaperOrientation','portrait');
set(h,'PaperSize',[H,W])
set(h,'PaperPosition',[0,0,W,H])

FN = findall(h,'-property','FontName');
set(FN,'FontName','/usr/share/fonts/dejavu/DejaVuSerifCondensed.ttf');
FS = findall(h,'-property','FontSize');
set(FS,'FontSize',11);

%======================================================================
% Always include code below for printing graphs
print(h, '-depslatex', '-color', 'graph.eps');
