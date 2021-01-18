clear;
P=10.0;
D=1.0;

s=poly(0,"s");
//Übertragungsfunktion
G=syslin('c',[1],[1+s^2]); //Regelstrecke
R=syslin('c',[P+s*D],[1]); //PD-Regler
Q=R*G; //offenen Kreis
H=Q/(1+Q); //Geschl. Kreis
t=[0:0.01:15];
u=sin(t).*exp(-t);
y=csim(u,t,H);
plot(t,y,"r");

