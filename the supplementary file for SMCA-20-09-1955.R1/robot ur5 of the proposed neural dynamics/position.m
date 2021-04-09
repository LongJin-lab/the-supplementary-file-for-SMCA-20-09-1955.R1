function [x,y,z]=position(q)
% The function calculates the position with joint angle as the input.
theta1=q(1);theta2=q(2);theta3=q(3);
theta4=q(4);theta5=q(5);theta6=q(6);
x=[0,0,-(17*cos(theta1)*cos(theta2))/40,(1569*cos(theta1)*sin(theta2)*sin(theta3))/4000 - (17*cos(theta1)*cos(theta2))/40 - (1569*cos(theta1)*cos(theta2)*cos(theta3))/4000,(2183*sin(theta1))/20000 - (17*cos(theta1)*cos(theta2))/40 + (1569*cos(theta1)*sin(theta2)*sin(theta3))/4000 - (1569*cos(theta1)*cos(theta2)*cos(theta3))/4000,(2183*sin(theta1))/20000 - (17*cos(theta1)*cos(theta2))/40 + (1893*cos(theta4)*(cos(theta1)*cos(theta2)*sin(theta3) + cos(theta1)*cos(theta3)*sin(theta2)))/20000 - (1893*sin(theta4)*(cos(theta1)*sin(theta2)*sin(theta3) - cos(theta1)*cos(theta2)*cos(theta3)))/20000 + (1569*cos(theta1)*sin(theta2)*sin(theta3))/4000 - (1569*cos(theta1)*cos(theta2)*cos(theta3))/4000,(2183*sin(theta1))/20000 - (17*cos(theta1)*cos(theta2))/40 + (823*cos(theta5)*sin(theta1))/10000 + (1893*cos(theta4)*(cos(theta1)*cos(theta2)*sin(theta3) + cos(theta1)*cos(theta3)*sin(theta2)))/20000 - (1893*sin(theta4)*(cos(theta1)*sin(theta2)*sin(theta3) - cos(theta1)*cos(theta2)*cos(theta3)))/20000 + (823*sin(theta5)*(cos(theta4)*(cos(theta1)*sin(theta2)*sin(theta3) - cos(theta1)*cos(theta2)*cos(theta3)) + sin(theta4)*(cos(theta1)*cos(theta2)*sin(theta3) + cos(theta1)*cos(theta3)*sin(theta2))))/10000 + (1569*cos(theta1)*sin(theta2)*sin(theta3))/4000 - (1569*cos(theta1)*cos(theta2)*cos(theta3))/4000];
y=[0,0, -(17*cos(theta2)*sin(theta1))/40,(1569*sin(theta1)*sin(theta2)*sin(theta3))/4000 - (17*cos(theta2)*sin(theta1))/40 - (1569*cos(theta2)*cos(theta3)*sin(theta1))/4000 ,(1569*sin(theta1)*sin(theta2)*sin(theta3))/4000 - (17*cos(theta2)*sin(theta1))/40 - (2183*cos(theta1))/20000 - (1569*cos(theta2)*cos(theta3)*sin(theta1))/4000, (1893*cos(theta4)*(cos(theta2)*sin(theta1)*sin(theta3) + cos(theta3)*sin(theta1)*sin(theta2)))/20000 - (17*cos(theta2)*sin(theta1))/40 - (2183*cos(theta1))/20000 - (1893*sin(theta4)*(sin(theta1)*sin(theta2)*sin(theta3) - cos(theta2)*cos(theta3)*sin(theta1)))/20000 + (1569*sin(theta1)*sin(theta2)*sin(theta3))/4000 - (1569*cos(theta2)*cos(theta3)*sin(theta1))/4000 ,(1893*cos(theta4)*(cos(theta2)*sin(theta1)*sin(theta3) + cos(theta3)*sin(theta1)*sin(theta2)))/20000 - (823*cos(theta1)*cos(theta5))/10000 - (17*cos(theta2)*sin(theta1))/40 - (2183*cos(theta1))/20000 - (1893*sin(theta4)*(sin(theta1)*sin(theta2)*sin(theta3) - cos(theta2)*cos(theta3)*sin(theta1)))/20000 + (823*sin(theta5)*(cos(theta4)*(sin(theta1)*sin(theta2)*sin(theta3) - cos(theta2)*cos(theta3)*sin(theta1)) + sin(theta4)*(cos(theta2)*sin(theta1)*sin(theta3) + cos(theta3)*sin(theta1)*sin(theta2))))/10000 + (1569*sin(theta1)*sin(theta2)*sin(theta3))/4000 - (1569*cos(theta2)*cos(theta3)*sin(theta1))/4000];
z=[0, 6446200305038995/72057594037927936,6446200305038995/72057594037927936 - (17*sin(theta2))/40, 6446200305038995/72057594037927936 - (1569*cos(theta2)*sin(theta3))/4000 - (1569*cos(theta3)*sin(theta2))/4000 - (17*sin(theta2))/40,6446200305038995/72057594037927936 - (1569*cos(theta2)*sin(theta3))/4000 - (1569*cos(theta3)*sin(theta2))/4000 - (17*sin(theta2))/40,(1893*sin(theta4)*(cos(theta2)*sin(theta3) + cos(theta3)*sin(theta2)))/20000 - (1569*cos(theta2)*sin(theta3))/4000 - (1569*cos(theta3)*sin(theta2))/4000 - (1893*cos(theta4)*(cos(theta2)*cos(theta3) - sin(theta2)*sin(theta3)))/20000 - (17*sin(theta2))/40 + 6446200305038995/72057594037927936, (1893*sin(theta4)*(cos(theta2)*sin(theta3) + cos(theta3)*sin(theta2)))/20000 - (1569*cos(theta2)*sin(theta3))/4000 - (1569*cos(theta3)*sin(theta2))/4000 - (823*sin(theta5)*(cos(theta4)*(cos(theta2)*sin(theta3) + cos(theta3)*sin(theta2)) + sin(theta4)*(cos(theta2)*cos(theta3) - sin(theta2)*sin(theta3))))/10000 - (1893*cos(theta4)*(cos(theta2)*cos(theta3) - sin(theta2)*sin(theta3)))/20000 - (17*sin(theta2))/40 + 6446200305038995/72057594037927936];