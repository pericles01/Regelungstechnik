//Gleichung der System: y..+6y.+5y=0
//Simulation Zeitbereich
function f=rechteSeite(t,y)
    x=y(1,1);
    v=y(2,1);
    f(1,1)=v;
    f(2,1)=-6*v-5*x;
endfunction
//Simulationszeit
t=linspace(0,30,3000);
//Anfangsbedingungen
y0=[1,0]';
t0=0;
//simulieren
y=ode(y0,t0,t,rechteSeite);
//Simulation Laplacebereich
s=poly(0,"s");
H=syslin('c',[1],[s^2+6*s+5]);
//Simulationszeit
t1=[0:0.1:30];
//Implus: Sprung
u=ones(1,301);
//simulieren
g=csim(u,t1,H);
//plotten
plot2d(t1,g); //Laplacebereich
plot(t,y(1,:),"br--",t,y(2,:),"gre"); //Zeitbereich
//Axenbeschriftung
a=gca();
a.x_label.text='s';
a.y_label.text='Weg(red)  /   Geschwindigkeit(green)';
a.title.text='Simulation';

