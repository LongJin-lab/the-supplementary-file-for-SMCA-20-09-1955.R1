function output=AFMbound(E)
% The function denotes the bound activation.
% upper_bound and lower_bound are two scalar parameters that need to be adjusted.

%Reference
%[1] L. Jin, S. Li, B. Liao, Z. Zhang, Zeroing neural networks: A survey, Neurocomputing, vol. 267, pp. 597-604, 2017.
%[2] L. Jin, Y. Zhang, S. Li and Y. Zhang, Modified ZNN for Time-Varying Quadratic Programming With Inherent Tolerance to Noises and Its Application to Kinematic Redundancy Resolution of Robot Manipulators, IEEE Transactions on Industrial Electronics, vol. 63, no. 11, pp. 6978-6988, Nov. 2016.
%[3] L. Jin, Y. Zhang, Continuous and discrete Zhang dynamics for real-time varying nonlinear optimization, Numerical Algorithm, 73, 115-140, 2016.
%[4] L. Jin, S. Li and B. Hu, RNN Models for Dynamic Matrix Inversion: A Control-Theoretical Perspective, IEEE Transactions on Industrial Informatics, vol. 14, no. 1, pp. 189-199, Jan. 2018.


upper_bound=1;
lower_bound=-1;
output=zeros(size(E));

for i=1:length(E)
    if E(i)>upper_bound
       E(i) = upper_bound;
    end
    if E(i)<lower_bound
        E(i) = lower_bound;
    end
end
for i=1:length(E)
   
     
        output(i) =E(i);
   
end
