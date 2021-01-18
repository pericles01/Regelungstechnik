clear();

m = 1;     //kg
g = 0.91;  // m/s^2
l = 1;     // m
h = l/2;   // m
r = 0.1;   // m

// siehe: http://www.kramann.info/54_Kinetik/02_NewtonEuler/01_Traegheitsmomente
J = 0.25*m*r*r + (1/12)*m*l*l; // kg*m^2 

//Vorgehen für Gesamtsystem analog wie beim Teilmodell:

A = [ 0,1,0,0 ;  m*g*h/J,0,0,0 ; 0,0,0,1 ; 0,0,0,0 ];
B = [ 0 ; h/J ; 0 ; 1/m ];



spec(A) //Eigenwerte der ursprünglichen Matrix ansehen
// ergibt:
//   2.3023837 + 0.i
//  -2.3023837 + 0.i
//   0.        + 0.i
//   0.        + 0.i
// technisch stabil wählen, an vorhandenen Werten orientieren:
// Regleranteil für x langsamer machen:
u=2.3023837;
v=1.0;
EW = [-u+%i*u, -u-%i*u, -v+v*%i, -v-v*%i ];

R = ppol(A,B,EW)
// ergibt (korrigiert wg. korrigiertem B 5.1.):
//   5.3409701   2.1187267  -3.9999999  -5.7373297

//testweise diesen Regler in das nicht linearisierte Modell einbauen und testen:

function f = rechteSeite(t,y)
    phi = y(1,1);
    om  = y(2,1);
    x   = y(3,1);
    v   = y(4,1);
    FA = -R * [phi;om;x;v];
    f(1,1) = om;
    N = J + m*h*h*sin(phi)*sin(phi);
    f(2,1) = (-m*h*h*om*om*sin(phi)*cos(phi) + h*m*sin(phi)*g + h*cos(phi)*FA )/N;
    f(3,1) = v;
    f(4,1) = FA/m;
endfunction

t = linspace(0,20,3000);
y0 = [10.0*%pi/180,0.0,0.0,0.0]';  //Start in der Nähe der instabilen Ruhelage
t0 = 0;
y  = ode(y0,t0,t,rechteSeite);

plot(t,y(1,:),t,y(2,:),t,y(3,:),t,y(4,:));
