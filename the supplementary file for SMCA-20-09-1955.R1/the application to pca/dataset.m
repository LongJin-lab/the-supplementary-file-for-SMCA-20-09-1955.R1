% To reduce the computing time in ODE function, 
% the derivative of different parameters could be calculated here in advance.

close all
clc
clear all

x=1*[0.69,0.39,0.09,1.29,0.49,0.19,-0.81,-0.31,-0.71];
y=1*[0.49,0.99,0.29,1.09,0.79,-0.31,-0.81,-0.31,-1.01];
noisex=1*rand(size(x));
noisey=1*rand(size(y));
noisez=1*rand(size(x));
noisem=1*rand(size(x));
% the used datasets in the manuscript
x=[x,x+noisex,x+0.2*noisey,x+0.3*noisem,x+0.5*noisem,x+0.6*noisem,x+0.7*noisem,x+0.11*noisem,x+0.33*noisem,x+0.11*noisem];
y=[y,y+noisey,y+0.2*noisez,y+0.3*noisem,y+0.7*noisem,y+0.6*noisem,y+0.5*noisem,y+0.22*noisem,y+0.44*noisem,y+0.33*noisem];
data1=x-sum(x)/size(x,2);
data2=y-sum(y)/size(y,2);
% 
da_mean=[data1;data2];
c=(1/size(x,2))*da_mean*da_mean';
[c1,c2]=eig(c);
w=c1(:,2);
z=w'*da_mean;
f=w*z;
figure (100);
plot(x,y,'o');
hold on
plot(f(1,:),f(2,:))
title('title');

syms s x1 x2
w=[x1;x2];
da=[data1;data2];
ff=1*(w'*da*da'*w)/(w'*w);
%g(x(t),t)
ff1= diff(ff,x1);
ff2= diff(ff,x2);

g_cs=[ff1;ff2;]
%hessian matrix
% dotf =jacobian(g_cs,[x1,x2,x3,x4,x5,x6,x7]);
dotf=jacobian(g_cs,[x1,x2])

%dg/dt
dotg=diff(g_cs,s)

