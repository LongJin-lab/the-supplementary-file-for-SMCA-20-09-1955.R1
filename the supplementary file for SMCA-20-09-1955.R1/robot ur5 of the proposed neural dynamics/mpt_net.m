function doty=mpt_net(t,y)
% The function implementes the computational flow of the proposed
% noise-suppressing neural dynamics (12) in the manuscript and return parameters for mpt_1.m

% Notice: the parameters that need to be adjusted.
% T denotes the time span.
% q0 and dq0 denote the initial joint angle and joint velocity.
% ec denotes the number of inequality constraints 
% iec denotes the number of equality constraints 
% n denotes the dimension of joint angle
% m denotes dimension of the working space of the end-effector
% gamma and eta denote the convergence factors of the proposed
% noise-suppressing neural dynamics

%Reference
%[1] L. Jin, S. Li, B. Liao, Z. Zhang, Zeroing neural networks: A survey, Neurocomputing, vol. 267, pp. 597-604, 2017.
%[2] L. Jin, Y. Zhang, S. Li and Y. Zhang, Modified ZNN for Time-Varying Quadratic Programming With Inherent Tolerance to Noises and Its Application to Kinematic Redundancy Resolution of Robot Manipulators, IEEE Transactions on Industrial Electronics, vol. 63, no. 11, pp. 6978-6988, Nov. 2016.
%[3] L. Jin, Y. Zhang, Continuous and discrete Zhang dynamics for real-time varying nonlinear optimization, Numerical Algorithm, 73, 115-140, 2016.
%[4] L. Jin, S. Li and B. Hu, RNN Models for Dynamic Matrix Inversion: A Control-Theoretical Perspective, IEEE Transactions on Industrial Informatics, vol. 14, no. 1, pp. 189-199, Jan. 2018.


global q dq iec ec dr eta gamma n;
q=y(1:n);
dq=y(n+1:n+n);

%the first and second derivative of desired trajectory with respect
%to time t
dr =0.3*[- (2*sin(2*t))/25 - (2*sin((4*t)/3))/15;
   (2*cos(2*t))/25 - (2*cos((4*t)/3))/25;
                             0];
ddr =0.3*[
 - (4*cos(2*t))/25 - (8*cos((4*t)/3))/45;
   (8*sin((4*t)/3))/75 - (4*sin(2*t))/25;
                                 0];
                                
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[J,DJ]=jdj(q,dq);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
delta=eps*ones(iec,1);
x=y(n+1:n+n);% u ¶ÔÓ¦ÓÚy(t) y£¨t£©=[x(t) lamda mu]
lambda=y(2*n+1:2*n+ec);
mu=y(2*n+ec+1:2*n+ec+iec);
yye=y(2*n+ec+iec+1:3*n+2*(ec+iec));
mW=zeros(6,6);
vd=0.5*ones(12,1);
mC=[eye(6,6);-1*eye(6,6)];
e=vd-mC*x;
D1=diag(e./sqrt(e.*e+mu.*mu+delta));
D2=diag(mu./sqrt(e.*e+mu.*mu+delta));

%--------------------------------------------
s=t;

x1=x(1);
x2=x(2);
x3=x(3);
x4=x(4);
x4=x(4);
x5=x(5);
x6=x(6);
g_cs=[x1;x2;x3;x4;x5;x6;];%Hessian matrix
dotf =[1, 0, 0, 0, 0, 0;
    0, 1, 0, 0, 0, 0;
    0, 0, 1, 0, 0, 0;
    0, 0, 0, 1, 0, 0;
    0, 0, 0, 0, 1, 0;
     0, 0, 0, 0, 0, 1];

%dg/dt
dotg =[0; 0; 0; 0; 0; 0];
%--------------------------------------------

mA=J;
dA=DJ;
vb=dr;
dB=ddr;
dW=zeros(n,n); 

g1= (g_cs);
z1=zeros(ec,ec);
z2=zeros(ec,iec);
z3=zeros(iec,ec);
z4=zeros(iec,iec);
dC=zeros(iec,n);
I=eye(iec,iec);
% the following parameters could be referred to equation (11) in the
% manuscript.
mM=[dotf mA' mC';mA z1 z2;(D1-I)*mC z3 I-D2];
mN=[dW dA' dC';dA z1 z2;dC z3 z4];
mH=[mW mA' mC';mA z1 z2;-mC z3 I];

g=[dotg;-dB;z3(:,1)];

v=[g1;-vb;vd-sqrt(e.*e+mu.*mu+delta)];
m_M=inv(mM);

noise=5*ones((n+ec+iec),1);
% the solution of the noise-suppressing neural dynamics (12) in the manuscript
dot_u=m_M*(-mN*y(n+1:2*n+ec+iec)-g-eta*AFMbound(mH*y(n+1:2*n+ec+iec)+v)-gamma*AFMbound((mH*y(n+1:2*n+ec+iec)+v)+eta*AFMbound(yye))+noise);
ye=mH*y(n+1:2*n+ec+iec)+v;
doty=[dq;dot_u;ye];
t
