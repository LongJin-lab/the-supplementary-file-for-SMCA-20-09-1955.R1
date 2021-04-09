% To reduce the computing time in ODE function, 
% the derivative of different parameters could be calculated here in advance.

syms s x1 x2 x3 x4 
ff=((sin(2*pi*x1)^3)*sin(2*pi*x2))/(x1^3*(x1+x2))+...
    (cos(0.1*s)+2)*x3^2+(cos(0.1*s)+2)*x4^2+2*sin(s)*x3*x4+sin(s)*x3+cos(s)*x4;

%g(x(t),t)
ff1= diff(ff,x1);
ff2= diff(ff,x2);
ff3= diff(ff,x3);
ff4= diff(ff,x4);

g_cs=[ff1;ff2;ff3;ff4]
%Hessian matrix
dotf =jacobian(g_cs,[x1,x2,x3,x4])

%dg/dt
dotg=diff(g_cs,s)

