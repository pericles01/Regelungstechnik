clear();
phi_tot=0;
om_tot=0;
//Reglerparameter
T_krit=1.45;
K_krit=19.75;

K=0.6*K_krit;
Tn=0.5*T_krit;
Tv=0.12*T_krit;

P=K;
I=K/ Tn;
D=K*Tv;
//Pendelparameter
m=1;
g=9.87;
J=0.012;
h=0.5;
//Funktion
function f=modell(y,t,dt)
    phi=y(1,1);
    om=y(2,1);
    e_integral=y(3,1);
    w=sin(t)*exp(-t);
    derw=cos(t)*exp(-t)-sin(t)*exp(-t);
    u=P*(w-phi_tot)+D*(derw-om_tot)+I*e_integral;
    f(1,1)=om;
    f(2,1)=u-m*g*h/J*phi;;
    f(3,1)=w-phi_tot;
endfunction


function yneu=ruku(y,t,dt)
k1=modell(y,t,dt);
k2=modell(y+0.5.*dt.*k1,t+0.5*dt);
k3=modell(y+0.5.*dt.*k2,t+0.5*dt);
k4=modell(y+dt.*k3,t+dt);
yneu=y+dt.*(k1+2.*k2+2.*k3+k4)./6;
endfunction

tmax = 20.0;
dt = 0.01;
schritte = ceil(tmax/dt);

yalt = [0,0]';
ysim = yalt;
t=0.0;
tt=t;

Ttot = 0.1;
anztot = round(Ttot/dt)
xtotarr = zeros(anztot,1);

for i=1:1:schritte
yneu=ruku(yalt,t,dt);
yalt=yneu;
ysim=[ysim,yalt];
tt =[tt,t];
t=t+dt;

xtot = xtotarr(modulo((i-1),anztot)+1);
xtotarr(modulo((i-1),anztot)+1)=yneu(1);
end

plot(tt,ysim(1,:));
