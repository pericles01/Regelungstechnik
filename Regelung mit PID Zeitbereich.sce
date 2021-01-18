clear;
//Systemgleichung: x..+x=u
//Zeitbereich
P=10;
D=1;
I=2.0;
function f=rechteSeite(t,y)
    x=y(1,1);
    v=y(2,1);
    e_integral=y(3,1);
    w=sin(t)*exp(-t);
    derw=cos(t)*exp(-t)-sin(t)*exp(-t);
    u=P*(w-x)+D*(derw-v)+I*e_integral; //PID Regler
    f(1,1)=v;
    f(2,1)=u-x;
    f(3,1)=w-x;
endfunction
//Simulationszeit
t=0:0.01:15;
//Anfangsbedingungen
t0=0;
y0=[1,0]';
//simulieren
y=ode(y0,t0,t,rechteSeite);

//Laplacebereich
s=poly(0,"s");
R=syslin('c',[1],[P+s*D+I/s]); //Regler
G=syslin('c',[1],[1+s^2]); //System
Q=G*R;//offenen Kreis
H=Q/(1+Q);//geschlossenen Kreis
t1=0:0.1:15;
u1=sin(t).*exp(-t);
g=csim(u1,t1,Q);

//plotten
plot(t,y(1,:)',t,y(2,:)');
plot2d(t,g);

//Axenbeschriftungen
a=gca();
a.x_label.text='t/s'
a.y_label.text='A/m2'
a.title.text='Simulation';
