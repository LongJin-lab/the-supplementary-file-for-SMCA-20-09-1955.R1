

function M=mA(t)
 % The function depicts equality constraints of equation (33) in the manuscript.

M=[0.1*sin(0.2*t)+0.5 -t*cos(0.2*t) 0 0;
    0 0 -sin(4*t) cos(4*t);
    ];

