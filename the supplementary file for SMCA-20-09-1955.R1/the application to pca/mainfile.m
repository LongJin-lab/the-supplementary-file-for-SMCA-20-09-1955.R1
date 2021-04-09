% The function computes the orthogonal weight vector of  PCA (32) in the manuscript.
% with the proposed noise-suppressing neural dynamics (12) compared with Newton method and normative eigenvector method.

% Notice: the parameters that need to be adjusted.
% tspan denotes the time span.
% u0 and u02 denote the initial values.
% p denotes the number of inequality constraints 
% m denotes the number of equality constraints 
% n denotes the dimension of the unknown variable
% gamma, alpha1 and gamma2 denote the convergence factors of the proposed
% neural dynamics and Newton method, respectively.

%Reference
%[1]S. Yi, Z. Lai, Z. He, Y.-M. Cheung, and Y. Liu, Joint sparse principal component analysis, Pattern Recogn., vol. 61, pp. 524-536, 2017.
%[2]J. H. M. Darbyshire, Pricing and Hedging of Interest Rate Derivatives: A Practical Guide to Swaps, Nottinghamshire, UK: Aitch & Dee Limited, 2016.

close all
clear all
clc

 m=0;
 n=2;
 p=4;

% The value of gamma, alpha, and gamma2 regulates the convergence speed.
% For different methods, the appropriate convergence values are also
% different.
gamma=1e4;
alpha=25;
gamma2=0.1;
Ini_num=1; 

for k=1:Ini_num   
u0=-10*ones(2*(n+m+p),1);
u02=-10*ones(1*(n+m+p),1);
time=[];
tspan=linspace(0,1);
options=odeset();
[t1,u1(:,:,k)]=ode45(@nsnd,tspan,u0,options,gamma,alpha,m,n,p); 
[t2,u2(:,:,k)]=ode45(@newton,tspan,u02,options,gamma2,m,n,p);

Num1=length(t1);
for i=1:Num1
   
    [mH,g]=error_model(t1(i),u1(i,1:n+m+p,k),m,n,p);
    NORM(i,k)=norm(mH*u1(i,1:n+m+p,k)'+g);
end

Num2=length(t2);

for i=1:Num2
    [mH2,g2]=error_model(t2(i),u2(i,1:n+m+p,k),m,n,p);
    NORM2(i,k)=norm(mH2*u2(i,1:n+m+p,k)'+g2);
end

% the residual errors of the proposed neural dynamics and Newton method.
% respectively
figure;
plot(t1,NORM(:,k));
hold on 
plot(t2,NORM2(:,k));

% the datasets 
da=1*[0.377001422937382,0.0770014229373819,-0.222998577062618,0.977001422937382,0.177001422937382,-0.122998577062618,-1.12299857706262,-0.622998577062618,-1.02299857706262,0.799569506614588,1.02073138136698,-0.221684179074374,1.95826933009204,0.747195605245834,0.223471977345851,-0.565495523953551,-0.323213874561044,-0.863925754536881,0.510052680111901,0.213841979592352,-0.0645167045929599,1.04672631046936,0.227016369607995,-0.0539979000038457,-1.05727205848952,-0.437501470484195,-0.871784090571877,0.501266779182179,0.275364168537777,0.0120468750340256,1.05136722522425,0.343329009593299,-0.0541229585219439,-1.12092474787151,-0.393006757892228,-1.01644860220830,0.584110350012045,0.407605998938041,0.168743843098455,1.10094442674882,0.454214067363911,-0.00820587949482782,-1.11954219507743,-0.239678878445301,-1.01208195230541,0.625532135426977,0.473726914138173,0.247092327130669,1.12573302751111,0.509656596249216,0.0147526600187302,-1.11885091868040,-0.163014938721838,-1.00989862735397,0.666953920841910,0.539847829338305,0.325440811162884,1.15052162827340,0.565099125134522,0.0377111995322883,-1.11815964228336,-0.0863509989983742,-1.00771530240253,0.422565386893808,0.149734429657527,-0.136815244627182,1.00426888377590,0.237988204711218,-0.0977441835977043,-1.12223817302588,-0.538668243366808,-1.02059691961603,0.513693314806659,0.295200443097817,0.0355514202436900,1.05880380545293,0.359961768258891,-0.0472353966678765,-1.12071736495240,-0.370007575975189,-1.01579360472286,0.422565386893808,0.149734429657527,-0.136815244627182,1.00426888377590,0.237988204711218,-0.0977441835977043,-1.12223817302588,-0.538668243366808,-1.02059691961603;0.160887153760605,0.660887153760605,-0.0391128462393948,0.760887153760605,0.460887153760605,-0.639112846239395,-1.13911284623940,-0.639112846239395,-1.33911284623939,0.826143439633200,1.34508993703546,0.753296516108896,1.10951159142050,0.710961887113673,-0.294109460945533,-0.810480253373893,0.288372686652722,-0.583040413785691,0.218534880445542,0.782123128990325,0.114093026608043,0.930117622615573,0.641283392136396,-0.519971416723619,-1.12540561731618,-0.595504171250572,-1.16523114793189,0.285152510005403,0.859249899361001,0.195932605857249,0.835252956047469,0.627214740416523,-0.570237227698721,-1.13703901704828,-0.409121027069005,-1.33256287138507,0.450839651665133,1.12373356016153,0.509326541986107,0.934407359096620,0.848984855957745,-0.478403069644488,-1.13427391146014,-0.102465268175151,-1.32382957157931,0.409417866250201,1.05761264496140,0.430978057953893,0.909618758334332,0.793542327072440,-0.501361609158046,-1.13496518785717,-0.179129207898614,-1.32601289653075,0.367996080835268,0.991491729761264,0.352629573921678,0.884830157572044,0.738099798187134,-0.524320148671605,-1.13565646425421,-0.255793147622078,-1.32819622148219,0.252015081673457,0.806353167200895,0.133253818631477,0.815422075437638,0.582860717308278,-0.588604059309567,-1.13759203816591,-0.470452178847775,-1.33430953134623,0.343143009586308,0.951819180641185,0.305620483502349,0.869956997114671,0.704834280855951,-0.538095272379739,-1.13607123009243,-0.301791511456156,-1.32950621645306,0.297579045629883,0.879086173921040,0.219437151066913,0.842689536276155,0.643847499082114,-0.563349665844653,-1.13683163412917,-0.386121845151965,-1.33190787389964];
% the generated orthogonal weight vector by the proposed neural dynamics
wf=1*u1(end,1:2)/norm(u1(end,1:2));
% one-dimensional (1-D) data after dimensionality reduction
zf=wf*da;
ff=wf'*zf;

% the generated orthogonal weight vector by Newton method
ws=1*u2(end,1:2)/norm(u2(end,1:2));
% one-dimensional (1-D) data after dimensionality reduction
zs=ws*da;
fs=ws'*zs;

% the generated orthogonal weight vector by the normative eigenvector method without
% the presence of noise
c=(1/(size(da,2)-1))*da*da';
[c1,c2]=eig(c);
w=1*c1(:,2);
% one-dimensional (1-D) data after dimensionality reduction
z2=w'*da;
f2=w*z2;
%----------------------------------------------------
x0=1.5; % the arbitrary start point 
% the end point of generated orthogonal weight vectors
testpoint=wf;
testpoint2=w;

% plot the orthogonal weight vectors that generated in the nominal situation 
figure;
h1=draw_arrow([0,0],[x0,x0*testpoint(2)/testpoint(1)]);
hold on
h2=plot(da(1,:),da(2,:),'o');
hold on
h3=draw_arrow([0,0],0.5*[x0,x0*testpoint2(2)/testpoint2(1)]);
legend([h1,h2,h3],'nsnd','data','eig')

% plot the orthogonal weight vectors that generated with the presence of noise 
figure;
testpoints=ws;
testpoint2=w;
h4=draw_arrow([0,0],[x0,x0*testpoints(2)/testpoints(1)]);
hold on
h5=plot(da(1,:),da(2,:),'o');
hold on
h6=draw_arrow([0,0],0.5*[x0,x0*testpoint2(2)/testpoint2(1)]);
legend([h4,h5,h6],'nr','data','eig')
%----------------------------------------------------

%plot the one-dimensional (1-D) data after dimensionality reduction
figure;
stem(1:1:(size(zf,2)),zf,'r');
hold on
stem(1:1:(size(zf,2)),z2,'b')
end
