set(0,'DefaultAxesFontSize',20);
set(0,'defaultLineLineWidth',1);

x=0:0.1:40;
x0=20;
h=5;                           % altura del poste h  [m] 
a=10;

X=x-x0;

%%%%%%caputo
y1=CatenaryCaputo(1.0,a,h,x,x0);
y2=CatenaryCaputo(0.95,a,h,x,x0);
y3=CatenaryCaputo(0.90,a,h,x,x0);
y4=CatenaryCaputo(0.85,a,h,x,x0);
y5=CatenaryCaputo(0.80,a,h,x,x0);
y6=CatenaryCaputo(0.75,a,h,x,x0);
  
figure,plot(X,y1,'k--',X,y2,'b',X,y3,'c',X,y4,'g',X,y5,'y',X,y6,'r')
xlabel('$x$  $[m]$','Interpreter','latex' );
ylabel('$y$ $[m]$','Interpreter','latex');
legend({'$\gamma=1$','$\gamma=0.95$','$\gamma=0.90$','$\gamma=0.85$','$\gamma=0.80$','$\gamma=0.75$'},'Interpreter','latex');
annotation('textarrow',[0.470134910367769 0.512992053224912],...
[0.277260331445354 0.229641283826306],'Color',[0 0 1],'String','p_1');

%%%%%%%%%%atangana-baleanu
% ya1=CatenaryABC(1,a,h,x,x0);
% ya2=CatenaryABC(0.95,a,h,x,x0);
% ya3=CatenaryABC(0.90,a,h,x,x0);
% ya4=CatenaryABC(0.85,a,h,x,x0);
% ya5=CatenaryABC(0.80,a,h,x,x0);
% ya6=CatenaryABC(0.75,a,h,x,x0);
% 
% figure,plot(X,ya1,'k--',X,ya2,'b',X,ya3,'c',X,ya4,'g',X,ya5,'y',X,ya6,'r')
% xlabel('$x$  $[m]$','Interpreter','latex' );
% ylabel('$y$ $[m]$','Interpreter','latex');
% legend({'$\gamma=1$','$\gamma=0.95$','$\gamma=0.90$','$\gamma=0.85$','$\gamma=0.80$','$\gamma=0.75$'},'Interpreter','latex');
% annotation('textarrow',[0.470134910367769 0.512992053224912],...
% [0.277260331445354 0.229641283826306],'Color',[0 0 1],'String','p_1');

%%%%%%%%%%conformable

% ya1=CatenaryConformable(1,a,h,x,x0);
%  ya2=CatenaryConformable(0.95,a,h,x,x0);
%  ya3=CatenaryConformable(0.90,a,h,x,x0);
%  ya4=CatenaryConformable(0.85,a,h,x,x0);
%  ya5=CatenaryConformable(0.80,a,h,x,x0);
%  ya6=CatenaryConformable(0.75,a,h,x,x0);
% 
% figure, plot(X,ya1,'k--',X,ya2,'b',X,ya3,'c',X,ya4,'g',X,ya5,'y',X,ya6,'r')
%  xlabel('$x$  $[m]$','Interpreter','latex' );
%  ylabel('$y$ $[m]$','Interpreter','latex');
%  legend({'$\gamma=1$','$\gamma=0.95$','$\gamma=0.90$','$\gamma=0.85$','$\gamma=0.80$','$\gamma=0.75$'},'Interpreter','latex');
%  annotation('textarrow',[0.470134910367769 0.512992053224912],...
%  [0.277260331445354 0.229641283826306],'Color',[0 0 1],'String','p_1');