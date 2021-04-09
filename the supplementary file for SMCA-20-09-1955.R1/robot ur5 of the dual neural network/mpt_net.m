function doty=mpt_net(t,y)
% The function implementes the computational flow of the dual neural
% network (29) in the manuscript and return parameters for mpt_1.m

% Notice: the parameters that need to be adjusted.
% n denotes the dimension of joint angle
% m denotes dimension of the working space of the end-effector
% gamma denotes the convergence factor of the dual neural network 

%Reference
%[1] Y. N. Zhang, J. Wang, and Y. Xia, A dual neural network for redundancy resolution of kinematically redundant manipulators subject to joint limits and joint velocity limits, IEEE Transactions on Neural Networks, vol. 14, no. 3, pp. 658-667, May 2003.
%[2] L. Jin, S. Li, B. Liao, Z. Zhang, Zeroing neural networks: A survey, Neurocomputing, vol. 267, pp. 597-604, 2017.
%[3] L. Jin, Y. Zhang, S. Li and Y. Zhang, Modified ZNN for Time-Varying Quadratic Programming With Inherent Tolerance to Noises and Its Application to Kinematic Redundancy Resolution of Robot Manipulators, IEEE Transactions on Industrial Electronics, vol. 63, no. 11, pp. 6978-6988, Nov. 2016.
%[4] L. Jin, Y. Zhang, Continuous and discrete Zhang dynamics for real-time varying nonlinear optimization, Numerical Algorithm, 73, 115-140, 2016.
%[5] L. Jin, S. Li and B. Hu, RNN Models for Dynamic Matrix Inversion: A Control-Theoretical Perspective, IEEE Transactions on Industrial Informatics, vol. 14, no. 1, pp. 189-199, Jan. 2018.


global m q dq dr gamma n;
q=y(1:n);
dq=y(n+1:n+n);
u=y(2*n+1:end);

%the first and second derivative of desired trajectory with respect
%to time t
dr =0.3*[- (2*sin(2*t))/25 - (2*sin((4*t)/3))/15;
   (2*cos(2*t))/25 - (2*cos((4*t)/3))/25;
                             0];%3x1
ddr =0.3*[
 - (4*cos(2*t))/25 - (8*cos((4*t)/3))/45;
   (8*sin((4*t)/3))/75 - (4*sin(2*t))/25;
                                 0];   
                             
[J,DJ]=jdj(q,dq);%J3x6
JE=[J;eye(n)];%9x6
rx=[dr;-0.5*ones(n,1)];
rs=[dr;0.5*ones(n,1)];
g=zeros(m+n,1);%6x1 n=6  
state1=JE*JE'*u-u;
for i=1:n+m
    if state1(i)<rx(i)
        g(i)=rx(i);
    elseif state1(i)>rs(i)
        g(i)=rs(i);
    else
        g(i)=state1(i);
    end
end
noise1=5*ones(n+m,1);
dot_u1=gamma*(g-JE*JE'*u+noise1);%9 1
dq=JE'*u;%6 1
DJE=[DJ;zeros(n,n)];
ddq=JE'*dot_u1+DJE'*u;
doty=[dq;ddq;dot_u1];% 6 6 9
t