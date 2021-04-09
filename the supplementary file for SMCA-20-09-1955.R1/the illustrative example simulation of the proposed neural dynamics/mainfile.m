% The function computes the optimal value of illustrative example (33)
% with the proposed noise-suppressing neural dynamics (12) in the
% manuscript

% Notice: the parameters that need to be adjusted.
% T denotes the time span.
% u1 denotes the initial value.
% p denotes the number of inequality constraints 
% m denotes the number of equality constraints 
% n denotes the dimension of the unknown variable
% gamma1 and alpha1 denote the convergence factors of the proposed
% noise-suppressing neural dynamics (12)

close all
clear all
clc

m=2;
n=4;
p=8;
T=4;

gamma1=10;
alpha1=1; 
uc1=0.01*rand(2*(n+m+p),1);
time=[];
tspan=linspace(0,T);
options=odeset();
[t1,u1(:,:)]=ode45(@nsnd,tspan,uc1,options,gamma1,alpha1,m,n,p); 
Num1=length(t1);
for i=1:Num1

    [mH1,g1]=error_model(t1(i),u1(i,1:n+m+p),m,n,p);
    NORM1(i)=norm(mH1*u1(i,1:n+m+p)'+g1);
end

%the performance on the residual error
figure
plot(t1,NORM1(:));

%the performance on the unknown variable and the inequality constraint
figure ;
subplot(2,2,1)
plot(t1,u1(:,1))
hold on 
plot(t1,1.3*ones(size(t1)));
hold on 
plot(t1,-1.3*ones(size(t1)));
subplot(2,2,2)
plot(t1,u1(:,2))
hold on 
plot(t1,1.3*ones(size(t1)));
hold on 
plot(t1,-1.3*ones(size(t1)));
subplot(2,2,3)
plot(t1,u1(:,3))
hold on 
plot(t1,1.3*ones(size(t1)));
hold on 
plot(t1,-1.3*ones(size(t1)));
subplot(2,2,4)
plot(t1,u1(:,4))
hold on 
plot(t1,1.3*ones(size(t1)));
hold on 
plot(t1,-1.3*ones(size(t1)));


%the performance on the equality constraint
eca1=[];
eca2=[];
ecb1=[];
ecb2=[];
for i=1:Num1
    ma=mA(t1(i));
    ma1=ma(1,:);
    ma2=ma(2,:);
    b=vb(t1(i));
    b1=b(1,:);
    b2=b(2,:);
    
    ec1=ma1*u1(i,1:4)';
    eca1=[eca1;ec1];
    
    ec2=ma2*u1(i,1:4)';
    eca2=[eca2;ec2];
    
    ecb1=[ecb1;b1];
    ecb2=[ecb2;b2];
end
figure;
subplot(2,1,1);
plot(t1,eca1)
hold on
plot(t1,ecb1)
subplot(2,1,2); 
plot(t1,eca2)
hold on
plot(t1,ecb2)

