% The function computes the joint angle with the noise-suppressing neural dynamics (12)
% in the manuscript and save parameters for mpt_2.m.

% Notice: the parameters that need to be adjusted.
% T denotes the time span.
% q0 and dq0 denote the initial joint angle and joint velocity.
% ec denotes the number of inequality constraints 
% iec denotes the number of equality constraints 
% n denotes the dimension of joint angle
% m denotes dimension of the working space of the end-effector
% gamma and eta denote the convergence factors of the proposed neural dynamics

%Reference
%[1] L. Jin, S. Li, B. Liao, Z. Zhang, Zeroing neural networks: A survey, Neurocomputing, vol. 267, pp. 597-604, 2017.
%[2] L. Jin, Y. Zhang, S. Li and Y. Zhang, Modified ZNN for Time-Varying Quadratic Programming With Inherent Tolerance to Noises and Its Application to Kinematic Redundancy Resolution of Robot Manipulators, IEEE Transactions on Industrial Electronics, vol. 63, no. 11, pp. 6978-6988, Nov. 2016.
%[3] L. Jin, Y. Zhang, Continuous and discrete Zhang dynamics for real-time varying nonlinear optimization, Numerical Algorithm, 73, 115-140, 2016.
%[4] L. Jin, S. Li and B. Hu, RNN Models for Dynamic Matrix Inversion: A Control-Theoretical Perspective, IEEE Transactions on Industrial Informatics, vol. 14, no. 1, pp. 189-199, Jan. 2018.

clc;
clear all
close all
format long;
global q0 T iec;


T=20;
q0=[0;pi/4;0;pi/2;-pi/4;0];
% q0=[-0.1;-1.1;-1;0.1;0.5;0.5];
%q0=[3.06147011763390,4.91919437438584,1.15856762876936,-1.76838518750552,1.865185438670004,2.65270000000000]';
global ec eta m n gamma;
ec=3;
iec=12;
n=6;
m=3;
gamma=1e3;
eta=1e3;
dq0=zeros(n,1);
[J0,DJ0]=jdj(q0,dq0);
yye0=zeros(n+ec+iec,1);
u0=[dq0;0.001*ones(ec+iec,1)];
init=[q0;u0;yye0];%acutally, abitrary initial y0
options=odeset();

tic;
[t,y]=ode15s('mpt_net',[0,T],init,options);%ode15s much better than ode45
cpu_time=toc;
%save cpu_time to "txt" file
fid=fopen('mvtn_cost_time.txt','a');
fprintf(fid,'Computing cost time: %g\n',cpu_time);
fclose(fid);
save mavn_SYSdata q0 eta T m gamma n;
save mavn_INITdata t y;
