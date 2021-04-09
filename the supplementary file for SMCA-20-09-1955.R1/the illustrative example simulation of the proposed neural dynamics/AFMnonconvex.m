function output=AFMnonconvex(E)
%The function denotes the nonconvex activation.

%Reference
%[1] L. Jin, S. Li, B. Liao, Z. Zhang, Zeroing neural networks: A survey,
% Neurocomputing, Volume 267,pp. 597-604, 2017.
%[2] L. Jin, Y. Zhang, S. Li and Y. Zhang, Modified ZNN for Time-Varying Quadratic Programming With Inherent Tolerance to Noises and Its Application to Kinematic Redundancy Resolution of Robot Manipulators, IEEE Transactions on Industrial Electronics, vol. 63, no. 11, pp. 6978-6988, Nov. 2016.
%[3] L. Jin, Y. Zhang, Continuous and discrete Zhang dynamics for real-time varying nonlinear optimization. Numer Algor 73, 115¨C140 (2016).
%[4] L. Jin, S. Li and B. Hu, RNN Models for Dynamic Matrix Inversion: A Control-Theoretical Perspective, IEEE Transactions on Industrial Informatics, vol. 14, no. 1, pp. 189-199, Jan. 2018.

%Provide by Lin wei (If you have any question, please contact me at weil20_AT_lzu.edu.cn)
%415Lab, Fieyun building, School of Information Science and Engineering, 
%Lanzhou University, Lanzhou 730000, China

output=zeros(size(E));

for i=1:length(E)
    if E(i)>0.55
       E(i) = 1;
    end
    if E(i)<-0.55
        E(i) = -1;
    end
end

for i=1:length(E)
    if E(i)>0.1
        if E(i)<0.55
       E(i) = 0.1;
        end
    end
    if E(i)<-0.1
           if E(i)>-0.55
       E(i) = -0.1;
        end
    end
end

for i=1:length(E)
   
     
        output(i) =E(i);
   
end

% for i=1:length(E)
%     if E(i)>0
%         Ei_gds = abs(E(i));
%         output(i) =Ei_gds.^r_gds+10*E(i);
%     end
%     if E(i)<0
%         Ei_gds = abs(E(i));
%         output(i) = -Ei_gds.^r_gds+10*E(i);
%     end
% end
