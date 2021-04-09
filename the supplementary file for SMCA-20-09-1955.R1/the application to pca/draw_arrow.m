function h1=draw_arrow(start_point, end_point)
% draw an arrow from the start_point to the end_point

K = 0.1;  %Arrow scale coefficient

theta = pi / 8;  %Arrow angle
A1 = [cos(theta), -sin(theta);
      sin(theta), cos(theta)];  %rotation matrix 
theta = -theta;
A2 = [cos(theta), -sin(theta);
      sin(theta), cos(theta)];  %rotation matrix 

arrow = start_point' - end_point';

arrow_1 = A1 * arrow;
arrow_2 = A2 * arrow;
arrow_1 = K * arrow_1 + end_point';
arrow_2 = K * arrow_2 + end_point';

hold on;
grid on;
axis equal;
h1=plot([start_point(1), end_point(1)], [start_point(2), end_point(2)], 'k');
h2=plot([arrow_1(1), end_point(1)], [arrow_1(2), end_point(2)], 'k');
h3=plot([arrow_2(1), end_point(1)], [arrow_2(2), end_point(2)], 'k');
hold off;