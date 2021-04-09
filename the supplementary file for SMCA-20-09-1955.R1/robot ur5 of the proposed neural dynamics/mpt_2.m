% The function computes the joint velocity with the noise-suppressing neural dynamics (12)
% in the manuscript and save parameters for mpt_3.m.

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
load mavn_INITdata;

interval=0.025;
jj=0;
epsilon=0;
for ii=1:length(t)
    if(t(ii,1)>=epsilon)
        jj=jj+1;
        tn(jj,1)=t(ii,1);
        yn(jj,:)=y(ii,:);
        epsilon=jj*interval;        
    elseif(ii==length(t))
        jj=jj+1;
        tn(jj,1)=t(ii,1);
        yn(jj,:)=y(ii,:);
        epsilon=jj*interval;
    end
end
clear t y;
t=tn;
y=yn;
size(t)
size(y)
clear tn yn;
qAll=y(:,1:n);
size(qAll)
dqAll=y(:,(n+1):(2*n));
size(dqAll)
uAll=y(:,(2*n+1):(3*n+m));
size(uAll)
ddqAll=uAll(:,1:n);
size(ddqAll)
%%%%%%%%%%%%%%%%%%%%
i=1;
for jj=1:4:length(t)
    qq(i,:)=qAll(jj,:);
    i=i+1;
end
%%%%%%%%%%%%%%%%%%%
save mavn_SNDdata t qAll dqAll uAll ddqAll;