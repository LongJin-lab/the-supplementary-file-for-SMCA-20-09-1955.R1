% The function mainly computes the position error of the dual neural network (29) 
% in the manuscript and save parameters for mpt_4.m.

% Notice: the parameters that need to be adjusted.
% T denotes the time span.
% q0 and dq0 denote the initial joint angle and joint velocity.
% n denotes the dimension of joint angle
% m denotes dimension of the working space of the end-effector
% gamma denotes the convergence factor of the dual neural network 

%Reference
%[1] L. Jin, S. Li, B. Liao, Z. Zhang, Zeroing neural networks: A survey, Neurocomputing, vol. 267, pp. 597-604, 2017.
%[2] L. Jin, Y. Zhang, S. Li and Y. Zhang, Modified ZNN for Time-Varying Quadratic Programming With Inherent Tolerance to Noises and Its Application to Kinematic Redundancy Resolution of Robot Manipulators, IEEE Transactions on Industrial Electronics, vol. 63, no. 11, pp. 6978-6988, Nov. 2016.
%[3] L. Jin, Y. Zhang, Continuous and discrete Zhang dynamics for real-time varying nonlinear optimization, Numerical Algorithm, 73, 115-140, 2016.
%[4] L. Jin, S. Li and B. Hu, RNN Models for Dynamic Matrix Inversion: A Control-Theoretical Perspective, IEEE Transactions on Industrial Informatics, vol. 14, no. 1, pp. 189-199, Jan. 2018.

clear all;
format long;

global q0;
load mavn_SYSdata;
load mavn_SNDdata;

[Ppx,Ppy,Ppz]=position(q0);
ix=Ppx(7);iy=Ppy(7);iz=Ppz(7);
for jj=1:length(t)
   qjj=qAll(jj,:)';%simulated end effector position
   [Ppx,Ppy,Ppz]=position(qjj);
   j2px(jj,1)=Ppx(3);
   j3px(jj,1)=Ppx(4);
   j4px(jj,1)=Ppx(5);
   j5px(jj,1)=Ppx(6);
   posx(jj,1)=Ppx(7);%joint6
   j2py(jj,1)=Ppy(3);
   j3py(jj,1)=Ppy(4);
   j4py(jj,1)=Ppy(5);
   j5py(jj,1)=Ppy(6);
   posy(jj,1)=Ppy(7);%joint6
   j2pz(jj,1)=Ppz(3);
   j3pz(jj,1)=Ppz(4);
   j4pz(jj,1)=Ppz(5);
   j5pz(jj,1)=Ppz(6);
   posz(jj,1)=Ppz(7);%joint6
   %-------------------------------------------------
   dqjj=dqAll(jj,:)';%simulated end effector velocity
   [J,DJ]=jdj(qjj,dqjj);
   dpos=J*dqjj;
   dposx(jj,1)=dpos(1);
   dposy(jj,1)=dpos(2);
   dposz(jj,1)=dpos(3);
   rx(jj,1)=0.3*(cos(2*t(jj))/25 + cos((4*t(jj))/3)/10)+ix-0.0420000000000000;
   ry(jj,1)=0.3*(sin(2*t(jj))/25 - (3*sin((4*t(jj))/3))/50)+iy;
   rz(jj,1)=iz;
   drx(jj,1)=0.3*(- (2*sin(2*t(jj)))/25 - (2*sin((4*t(jj))/3))/15);
   dry(jj,1)=0.3*( (2*cos(2*t(jj)))/25 - (2*cos((4*t(jj))/3))/25);
   drz(jj,1)=0;
   ddrx(jj,1)=0.3*(- (4*cos(2*t(jj)))/25 - (8*cos((4*t(jj))/3))/45);
   ddry(jj,1)=0.3*((8*sin((4*t(jj))/3))/75 - (4*sin(2*t(jj)))/25);
   ddrz(jj,1)=0;
end
%--Errors-
erposx=rx-posx;
erposy=ry-posy;
erposz=rz-posz;
erdposx=drx-dposx;
erdposy=dry-dposy;
erdposz=drz-dposz;

save mavn_SRDdata1 t qAll dqAll  posx posy posz dposx dposy dposz;
save mavn_SRDdata2 erposx erposy erposz erdposx erdposy erdposz; 
save mavn_SRDdata3 j2px j3px j4px j5px j2py j3py j4py j5py j2pz j3pz j4pz j5pz rx ry rz;
