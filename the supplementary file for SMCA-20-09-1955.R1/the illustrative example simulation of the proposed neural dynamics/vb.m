

function M=vb(t)
% The function corresponds to the equality constraint of equation (33) in the manuscript.
M=[t*sin(2*t);
    -0.4*cos(2*t)-0.25; 
   ];