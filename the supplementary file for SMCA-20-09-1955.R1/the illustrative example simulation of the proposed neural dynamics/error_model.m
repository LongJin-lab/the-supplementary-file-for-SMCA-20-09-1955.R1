
function [mH,g]=error_model(t,u,m,n,p)
% The function calculates the residual error of the involved methods.
delta=eps*ones(p,1);

x=u(1:n) ;

mu=u(n+m+1:n+m+p)';

e=vd(t)-mC(t)*x';

syms s x1 x2 x3 x4

B=vb(s);

ff=t*(cos(0.1*t)+2)*x1^2+(cos(0.1*t)+2)*x2^2+...
    2*sin(t)*x1*x2+sin(t)*x1+cos(t)*x2-...
     t*x3^2-10*x4^2-0.5*x3*x4-x3-x4;
ff1= diff(ff,x1);
ff2= diff(ff,x2);
ff3= diff(ff,x3);
ff4= diff(ff,x4);

g_cs=[ff1;ff2;ff3;ff4];
%Hessian matrix
s=t;
dB=eval(B);


x1=u(1);
x2=u(2);
x3=u(3);
x4=u(4);
g1=eval(g_cs);
dQ=g1;


z1=zeros(m,m);
z2=zeros(m,p);
z3=zeros(p,m);
I=eye(p,p);
mW=zeros(n,n);
mH=[mW mA(t)' mC(t)';mA(t) z1 z2;-mC(t) z3 I];

g=[dQ;-dB;vd(t)-sqrt(e.*e+mu.*mu+delta)];