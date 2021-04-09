function [Jacob0,dotJacob0]=jdj(theta,dq)
% The function calculates the Jacobian matrix and its derivative with regard to time t. 

%Reference
%[1] L. Jin, S. Li, B. Liao, Z. Zhang, Zeroing neural networks: A survey, Neurocomputing, vol. 267, pp. 597-604, 2017.
%[2] L. Jin, Y. Zhang, S. Li and Y. Zhang, Modified ZNN for Time-Varying Quadratic Programming With Inherent Tolerance to Noises and Its Application to Kinematic Redundancy Resolution of Robot Manipulators, IEEE Transactions on Industrial Electronics, vol. 63, no. 11, pp. 6978-6988, Nov. 2016.
%[3] L. Jin, Y. Zhang, Continuous and discrete Zhang dynamics for real-time varying nonlinear optimization, Numerical Algorithm, 73, 115-140, 2016.
%[4] L. Jin, S. Li and B. Hu, RNN Models for Dynamic Matrix Inversion: A Control-Theoretical Perspective, IEEE Transactions on Industrial Informatics, vol. 14, no. 1, pp. 189-199, Jan. 2018.


d1=89.459/1000;
d4=109.15/1000;
d5=94.65/1000;
d6=82.3/1000;
a2=-425/1000;
a3=-392.25/1000;
theta1=theta(1);theta2=theta(2);theta3=theta(3);
theta4=theta(4);theta5=theta(5);theta6=theta(6);
    A1=[cos(theta1), 0,  sin(theta1), 0;...
      sin(theta1), 0, -cos(theta1), 0;...
           0, 1,            0, d1;...
           0, 0,            0, 1];   
	DA1=[-sin(theta1),0,cos(theta1),0;...
		 cos(theta1),0,sin(theta1),0;...
		 0,0,0,0;...
		 0,0,0,0];
	DDA1=[-cos(theta1),0,-sin(theta1),0;...
		  -sin(theta1),0, -cos(theta1),0;...
		  0,0,0,0;...
		  0,0,0,0];
A2=...
[ cos(theta2), -sin(theta2), 0, a2*cos(theta2);...
  sin(theta2),  cos(theta2), 0, a2*sin(theta2);...
            0,            0, 1,                       0;...
            0,            0, 0,                       1];
	DA2=[-sin(theta2),-cos(theta2),0,-a2*sin(theta2);...
		 cos(theta2),-sin(theta2),0,a2*cos(theta2);...
		 0,0,0,0;...
		 0,0,0,0];
	DDA2=[-cos(theta2),sin(theta2),0,-a2*cos(theta2);...
		  -sin(theta2),-cos(theta2),0,-a2*sin(theta2);...
		  0,0,0,0;...
		  0,0,0,0];
	A3=...
 [cos(theta3),  -sin(theta3), 0,cos(theta3)*a3;...
  sin(theta3),   cos(theta3), 0,sin(theta3)*a3;...
            0,  0,            1,              0;...
            0,  0,            0,              1];
	DA3=[-sin(theta3),-cos(theta3),0,-sin(theta3)*a3;...
		 cos(theta3),-sin(theta3),0,cos(theta3)*a3;...
		 0,0,0,0;...
		 0,0,0,0];
	DDA3= [-cos(theta3),  sin(theta3), 0,-cos(theta3)*a3;...
  -sin(theta3),   -cos(theta3), 0,-sin(theta3)*a3;...
            0,  0,            0,              0;...
            0,  0,            0,              0];
	A4=...
[ cos(theta4), 0,  sin(theta4),         0;...
  sin(theta4), 0, -cos(theta4),         0;...
            0, 1,            0,         d4;...
            0, 0,            0,         1];
	DA4=[-sin(theta4),0,cos(theta4),0;...
		 cos(theta4),0,sin(theta4),0;...
		 0,0,0,0;...
		 0,0,0,0];
	DDA4=[-cos(theta4),0,-sin(theta4),0;...
		  -sin(theta4),0,cos(theta4),0;...
		  0,0,0,0;...
		  0,0,0,0];
	A5=[ cos(theta5),  0, -sin(theta5), 0;...
  sin(theta5),  0,  cos(theta5), 0;...
            0, -1,            0, d5;...
            0,  0,            0, 1];
	DA5=[-sin(theta5),0,-cos(theta5),0;...
		 cos(theta5),0,-sin(theta5),0;...
		 0,0,0,0;...
		 0,0,0,0];
	DDA5=[-cos(theta5),0,sin(theta5),0;...
		  -sin(theta5),0,-cos(theta5),0;...
		  0,0,0,0;...
		  0,0,0,0];
	A6=[ cos(theta6), -sin(theta6), 0,    0;...
  sin(theta6),  cos(theta6), 0,    0;...
            0,            0, 1,    d6;...
            0,            0, 0,    1];
	DA6=[-sin(theta6),-cos(theta6),0,0;...
		 cos(theta6),-sin(theta6),0,0;...
		 0,0,0,0;...
		 0,0,0,0];
	DDA6=[-cos(theta6),sin(theta6),0,0;...
		  -sin(theta6),-cos(theta6),0,0;...
		  0,0,0,0;...
		  0,0,0,0];
	A6v=A6*[0.0;0.0;0.0;1.0];
	A56v=A5*A6v;
	A456v=A4*A56v;
	A3456v=A3*A456v;
	A23456v=A2*A3456v;
	Je1=DA1*A23456v;
	D2A3456v=DA2*A3456v;
    Je2=A1*D2A3456v;
    D3A456v=DA3*A456v;
    A2D3A456v=A2*D3A456v;
    Je3=A1*A2D3A456v;
    D4A56v=DA4*A56v;
    A3D4A56v=A3*D4A56v;
    A23D4A56v=A2*A3D4A56v;
    Je4=A1*A23D4A56v;
    D5A6v=DA5*A6v;
    A4D5A6v=A4*D5A6v;
    A34D5A6v=A3*A4D5A6v;
    A234D5A6v=A2*A34D5A6v;
    Je5=A1*A234D5A6v;
    D6v=DA6*[0.0;0.0;0.0;1.0];
    A5D6v=A5*D6v;
    A45D6v=A4*A5D6v;
    A345D6v=A3*A45D6v;
    A2345D6v=A2*A345D6v;
    Je6=A1*A2345D6v;
    Jacob0(:,1)=Je1(1:3,1);
    Jacob0(:,2)=Je2(1:3,1);
    Jacob0(:,3)=Je3(1:3,1);
    Jacob0(:,4)=Je4(1:3,1);
    Jacob0(:,5)=Je5(1:3,1);
    Jacob0(:,6)=Je6(1:3,1);
    DJe11=DDA1*A23456v*dq(1);%column 1
    D12A3456v=DA1*D2A3456v;
    DJe12=D12A3456v*dq(2);
    D1A2D3A456v=DA1*A2D3A456v;
    DJe13=D1A2D3A456v*dq(3);
    D1A23D4A56v=DA1*A23D4A56v;
    DJe14=D1A23D4A56v*dq(4);
    D1A234D5A6v=DA1*A234D5A6v;
    DJe15=D1A234D5A6v*dq(5);
    D1A2345D6v=DA1*A2345D6v;
    DJe16=D1A2345D6v*dq(6);
    DJtemp=DJe11+DJe12+DJe13+DJe14+DJe15+DJe16;
    dotJacob0(:,1)=DJtemp(1:3,1);
    DJe11=D12A3456v*dq(1);%column 2
    DJe12=A1*(DDA2*A3456v)*dq(2);
    A1D23A456v=A1*(DA2*D3A456v);
    DJe13=A1D23A456v*dq(3);
    A1D2A3D4A56v=A1*(DA2*A3D4A56v);
    DJe14=A1D2A3D4A56v*dq(4);
    A1D2A34D5A6v=A1*(DA2*A34D5A6v);
    DJe15=A1D2A34D5A6v*dq(5);
    A1D2A345D6v=A1*(DA2*A345D6v);
    DJe16=A1D2A345D6v*dq(6);
    DJtemp=DJe11+DJe12+DJe13+DJe14+DJe15+DJe16;
    dotJacob0(:,2)=DJtemp(1:3,1);
    DJe11=D1A2D3A456v*dq(1);%column 3
    DJe12=A1D23A456v*dq(2);
    Je6=A2*(DDA3*A456v);%Je6 as a temp
    DJe13=A1*Je6*dq(3);
    Je6=A2*(DA3*D4A56v);%Je6 as a temp
    A12D34A56v=A1*Je6;%Je6 as a temp
    DJe14=A12D34A56v*dq(4);
    Je6=A2*(DA3*A4D5A6v);%Je6 as a temp
    A12D3A4D5A6v=A1*Je6;%Je6 as a temp
    DJe15=A12D3A4D5A6v*dq(5);
    Je6=A2*(DA3*A45D6v);%Je6 as a temp
    A12D3A45D6v=A1*Je6;%Je6 as a temp
    DJe16=A12D3A45D6v*dq(6);
    DJtemp=DJe11+DJe12+DJe13+DJe14+DJe15+DJe16;
    dotJacob0(:,3)=DJtemp(1:3,1);
    DJe11=D1A23D4A56v*dq(1);%column 4
    DJe12=A1D2A3D4A56v*dq(2);
    DJe13=A12D34A56v*dq(3);
    Je6=A3*(DDA4*A56v);%Je6 as a temp
    Je6=A1*(A2*Je6);%Je6 as a temp
    DJe14=Je6*dq(4);
    Je6=A3*(DA4*D5A6v);%Je6 as a temp
    A123D45A6v=A1*(A2*Je6);
    DJe15=A123D45A6v*dq(5);
    Je6=A3*(DA4*A5D6v);%Je6 as a temp
    A123D4A5D6v=A1*(A2*Je6);
    DJe16=A123D4A5D6v*dq(6);
    DJtemp=DJe11+DJe12+DJe13+DJe14+DJe15+DJe16;
    dotJacob0(:,4)=DJtemp(1:3,1);
    DJe11=D1A234D5A6v*dq(1);%column 5
    DJe12=A1D2A34D5A6v*dq(2);
    DJe13=A12D3A4D5A6v*dq(3);
    DJe14=A123D45A6v*dq(4);
    Je6=A4*(DDA5*A6v);%Je6 as a temp
    Je6=A2*(A3*Je6);
    DJe15=A1*Je6*dq(5);
    Je6=A4*(DA5*D6v);%Je6 as a temp
    Je6=A2*(A3*Je6);
    A1234D56v=A1*Je6;
    DJe16=A1234D56v*dq(6);
    DJtemp=DJe11+DJe12+DJe13+DJe14+DJe15+DJe16;
    dotJacob0(:,5)=DJtemp(1:3,1);
    DJe11=D1A2345D6v*dq(1);%column 6
    DJe12=A1D2A345D6v*dq(2);
    DJe13=A12D3A45D6v*dq(3);
    DJe14=A123D4A5D6v*dq(4);
    DJe15=A1234D56v*dq(5);
    Je6=A5*(DDA6*[0.0;0.0;0.0;1.0]);%Je6 as a temp
    Je6=A3*(A4*Je6);
    Je6=A1*(A2*Je6);
    DJe16=Je6*dq(6);
    DJtemp=DJe11+DJe12+DJe13+DJe14+DJe15+DJe16;
    dotJacob0(:,6)=DJtemp(1:3,1);