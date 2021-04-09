function y=nsnd(t,u,gamma,alpha,m,n,p)
% The function implementes the computational flow of the proposed noise-suppressing 
% neural dynamics (12) in the manuscript and return parameters for mainfile.m.
mW=zeros(n,n);
dW=zeros(n,n); 
delta=eps*ones(p,1);

x=u(1:n);
lambda=u(n+1:n+m);
mu=u(n+m+1:n+m+p);
e=vd(t)-mC(t)*x;
D1=diag(e./sqrt(e.*e+mu.*mu+delta));
D2=diag(mu./sqrt(e.*e+mu.*mu+delta));
yye=u(n+m+p+1:2*(n+m+p));

%-------------------------------------------------------
s=t;
x1=u(1);
x2=u(2);
x3=u(3);
x4=u(4);


dA =[cos(s/5)/50, (s*sin(s/5))/5 - cos(s/5), 0,  0;
    0, 0, -4*cos(4*s), -4*sin(4*s)];
dB=[ sin(2*s) + 2*s*cos(2*s);(4*sin(2*s))/5];
ff =s*(cos(s/10) + 2)*x1^2 + 2*sin(s)*x1*x2 + sin(s)*x1 + (cos(s/10) + 2)*x2^2 + cos(s)*x2 - s*x3^2 - (x3*x4)/2 - x3 - 10*x4^2 - x4;

%To reduce the computing time in ODE function, the derivative of different 
% parameters is calculated in file: information of the objective function, and 
% then could be used here.
g1 =[ sin(s) + 2*x2*sin(s) + 2*s*x1*(cos(s/10) + 2);
   cos(s) + 2*x2*(cos(s/10) + 2) + 2*x1*sin(s);
                           - x4/2 - 2*s*x3 - 1;
                            - x3/2 - 20*x4 - 1;];
%Hessian matrix
dotf =[ 2*s*(cos(s/10) + 2),        2*sin(s),    0,    0;
            2*sin(s), 2*cos(s/10) + 4,    0,    0;
                 0,               0, -2*s, -1/2;
                   0,               0, -1/2,  -20];
dotg =[ cos(s) + 2*x1*(cos(s/10) + 2) + 2*x2*cos(s) - (s*x1*sin(s/10))/5;
                          2*x1*cos(s) - (x2*sin(s/10))/5 - sin(s);
                                                            -2*x3;
                                                                0];

%-------------------------------------------------------

z1=zeros(m,m);
z2=zeros(m,p);
z3=zeros(p,m);
z4=zeros(p,p);
dC=zeros(p,n);
I=eye(p,p);

% the following parameters could be referred to equation (11) in the
% manuscript.
mM=[dotf mA(t)' mC(t)';mA(t) z1 z2;(D1-I)*mC(t) z3 I-D2];
mN=[dW dA' dC';dA z1 z2;dC z3 z4];
mH=[mW mA(t)' mC(t)';mA(t) z1 z2;-mC(t) z3 I];
g=[dotg;-dB;z3(:,1)];
v=[g1;-vb(t);vd(t)-sqrt(e.*e+mu.*mu+delta)];
m_M=inv(mM);


% noise=0;
 noise=2*rand((n+m+p),1);
% noise=1*ones((n+m+p),1);

% the solution of the noise-suppressing neural dynamics (12) in the manuscript
dot_u=m_M*(-mN*u(1:n+m+p)-g-gamma*AFMlinear(mH*u(1:n+m+p)+v)-alpha*AFMbound((mH*u(1:n+m+p)+v)+gamma*AFMlinear(yye))+noise);%n+m+2*pŒ¨œÚ¡ø
ye=mH*u(1:n+m+p)+v;
y=[dot_u;ye];
t



