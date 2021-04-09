% The function plots the position error of the noise-suppressing neural dynamics (12)
% in the manuscript and save parameters for mpt_5.m.

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


clear;
format long;
load mavn_SYSdata;
load mavn_SRDdata1;
load mavn_SRDdata2;
load mavn_SRDdata3;

%==plotting angles==
figure;%1
plot(t,qAll);hold on;
title('Simulated theta');
xlabel('Time (Second)');
legend('q1','q2','q3','q4','q5','q6');

figure;%2
plot(t,dqAll);hold on;
title('Simulated dotTheta');
xlabel('Time (Second)');
legend('dq1','dq2','dq3','dq4','dq5','dq6');

figure;%3
plot(t,ddqAll);hold on;
title('Simulated dotdotTheta');
xlabel('Time (Second)');
legend('ddq1','ddq2','ddq3','ddq4','ddq5','ddq6');

figure%4
plot(t,uAll(:,1:7));hold on;
xlabel('Time (Second)');


%==plotting 3d trajectories of joints==
figure;%6
grid on;
plot3(j2px,j2py,j2pz);hold on;
plot3(j3px,j3py,j3pz);hold on;
plot3(j4px,j4py,j4pz);hold on;
plot3(j5px,j5py,j5pz);hold on;
%plot3(posx,posy,posz);hold on;
xlabel('Time (Second)');
title('joints Position');
legend('X','Y','Z');

%==plotting end effector==
figure;%7
plot(t,posx,t,posy,t,posz);hold on;
%axis([0 10 -0.5 1]);
xlabel('Time (Second)');
title('End Effector Position');
legend('X','Y','Z');

figure;%8
plot(t,dposx,t,dposy,t,dposz);
%axis([0 10 -0.2 0.2]);
xlabel('Time (Second)');
title('End Effector Velocity');
legend('dX','dY','dZ');

figure;%9
plot(t,ddposx,t,ddposy,t,ddposz);
%axis([0 10 -0.2 0.2]);
xlabel('Time (Second)');
title('End Effector Acceleration');
legend('ddX','ddY','ddZ');

figure;%10
plot(t,erposx,t,erposy,t,erposz);
title('Position Error');
xlabel('Time (Second)');
legend('ex','ey','ez');

figure;%11
plot(t,erdposx,t,erdposy,t,erdposz);
title('Velocity Error');
xlabel('Time (Second)');
legend('edx','edy','edz');

figure;%12
plot(t,erddposx,t,erddposy,t,erddposz);
%axis([0 10 -15*10^-5 15*10^-5]);
title('Acceleration Error');
legend('eddx','eddy','eddz');
xlabel('Time (Second)');

figure;%
plot3(posx,posy,posz,'r');
hold on;
plot3(rx,ry,rz,'b');
grid on;
hold on;
xlabel('x');
ylabel('y');
zlabel('z');

[Ppx,Ppy,Ppz]=position(qAll(1,:));
pos_initial=[Ppx Ppy Ppz];
[Ppx,Ppy,Ppz]=position(qAll(length(t),:));
pos_final=[Ppx Ppy Ppz];
