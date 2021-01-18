clear;
//Zeitbereich
m=1.0;
C=1.0;
D=2.0;

function f=rechteSeite(t,y)
    x=y(1,1);
    v=y(2,1);
    f(1,1)=v;
    f(2,1)=-(C/m)*x-(D/m)*v;
endfunction
t=linspace(0,30,3000);
y0=[1,0]';
t0=0;
y=ode(y0,t0,t,rechteSeite);
plot(t,y(1,:)',t,y(2,:)');
//Laplacebereich
//s=poly(0,"s");
//G=syslin('c',[1],[s^2+10*s+1]);
//t=[0:0,1:1001];
//u=ones(1,1001);
//y=csim(u,t,G);
//plot2d(t,y);
