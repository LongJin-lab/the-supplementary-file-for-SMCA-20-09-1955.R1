% The function mainly plots the position error of the dual neural network (29) 
% in the manuscript and save parameters for mpt_5.m.

%Reference
%[1] L. Jin, S. Li, B. Liao, Z. Zhang, Zeroing neural networks: A survey, Neurocomputing, vol. 267, pp. 597-604, 2017.
%[2] L. Jin, Y. Zhang, S. Li and Y. Zhang, Modified ZNN for Time-Varying Quadratic Programming With Inherent Tolerance to Noises and Its Application to Kinematic Redundancy Resolution of Robot Manipulators, IEEE Transactions on Industrial Electronics, vol. 63, no. 11, pp. 6978-6988, Nov. 2016.
%[3] L. Jin, Y. Zhang, Continuous and discrete Zhang dynamics for real-time varying nonlinear optimization, Numerical Algorithm, 73, 115-140, 2016.
%[4] L. Jin, S. Li and B. Hu, RNN Models for Dynamic Matrix Inversion: A Control-Theoretical Perspective, IEEE Transactions on Industrial Informatics, vol. 14, no. 1, pp. 189-199, Jan. 2018.


clear;
close all
format long;
load mavn_SYSdata;
load mavn_SRDdata1;
load mavn_SRDdata2;
load mavn_SRDdata3;

%==plotting angles==
figure;
plot(t,qAll);hold on;
title('Simulated theta');
xlabel('Time (Second)');
legend('q1','q2','q3','q4','q5','q6');

figure;
plot(t,dqAll);hold on;
plot(t,0.5*ones(size(t)));
hold on;
plot(t,-0.5*ones(size(t)));
legend('dq1','dq2','dq3','dq4','dq5','dq6');

%==plotting 3d trajectories of joints==
figure;
grid on;
plot3(j2px,j2py,j2pz);hold on;
plot3(j3px,j3py,j3pz);hold on;
plot3(j4px,j4py,j4pz);hold on;
plot3(j5px,j5py,j5pz);hold on;
xlabel('Time (Second)');
title('joints Position');
legend('X','Y','Z');

figure;
plot(t,posx,t,posy,t,posz);hold on;
xlabel('Time (Second)');
title('End Effector Position');
legend('X','Y','Z');

figure;
plot(t,erposx,t,erposy,t,erposz);
title('Position Error');
xlabel('Time (Second)');
legend('ex','ey','ez');

figure;
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
