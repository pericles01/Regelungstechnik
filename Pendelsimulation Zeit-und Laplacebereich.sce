clear;
m=1;
g=9.87;
J=0.012;
h=0.5;
//Zeitbereich
function f=rechteSeite(t,y)
    phi=y(1,1);
    w=y(2,1);
    f(1,1)=w;
    f(2,1)=-m*g*h/J*phi;
endfunction
t=linspace(0,0.1,10);
y0=[1,0]';
t0=0;
y=ode(y0,t0,t,rechteSeite);
plot(t,y(1,:)',t,y(2,:)');
//mit Systemmatrix
function f=rechteSeite(t,y)
    A=[0,1;-m*g*h/J,0];
    f=A*y;
endfunction
t=0:0.1:10;
t0=0;
y0=[1,0]';

y=ode(y0,t0,t,rechteSeite);

plot(t,y(1,:),t,y(2,:));

//im Laplacebereich
s=poly(0,"s");
G=syslin('c',[1],[J*s^2+m*g*h]);
t=0:0.1:10;
u=ones(1,101);
y=csim(u,t,G);
plot2d(t,y);

