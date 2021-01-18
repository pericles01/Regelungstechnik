clear();
//Reglerparameter
T_krit=1.45;
K_krit=19.75;

K=0.6*K_krit;
Tn=0.5*T_krit;
Tv=0.12*T_krit;

P=K;
I=K/ Tn;
D=K*Tv;
tot=0.1;
//Schwingerparameter 
//Gleichung: x..+D/m x. +C/m x=u
m=1.0;
C=1.0;
D=2.0;

s=poly(0,"s");//s als unbekannt definieren

R=syslin('c',[exp(-tot*s)],[P+I/s+D*s]);//Gleichung PID+Totzeit im Laplace
G=syslin('c',[1],[s^2+D/m*s+C/m]);//DGl im Laplace

H=R*G;//offenen Kreis

t=[0:0.1:100];//Simulationszeit
u=ones(1,1001);//Implus Sprung
g=csim(u,t,G);//simulieren ohne Regler
y=csim(u,t,H);//simulieren mit Regler

plot2d(t,y,"br--",t,g,"gre");
//Axenbeschriftung
a=gca();
a.x_label.text='Zeit/ s';
a.y_label.text='ohne Regler (Green) vs mit Regler (Red)';
a.title.text='Schwingersimulation mit PID+Totzeit';


