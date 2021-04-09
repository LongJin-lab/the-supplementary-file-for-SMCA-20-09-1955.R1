% The function plots the 3-D view of robotic manipulator conducting motion planning task.
%Reference
%[1] L. Jin, S. Li, B. Liao, Z. Zhang, Zeroing neural networks: A survey, Neurocomputing, vol. 267, pp. 597-604, 2017.
%[2] L. Jin, Y. Zhang, S. Li and Y. Zhang, Modified ZNN for Time-Varying Quadratic Programming With Inherent Tolerance to Noises and Its Application to Kinematic Redundancy Resolution of Robot Manipulators, IEEE Transactions on Industrial Electronics, vol. 63, no. 11, pp. 6978-6988, Nov. 2016.
%[3] L. Jin, Y. Zhang, Continuous and discrete Zhang dynamics for real-time varying nonlinear optimization, Numerical Algorithm, 73, 115-140, 2016.
%[4] L. Jin, S. Li and B. Hu, RNN Models for Dynamic Matrix Inversion: A Control-Theoretical Perspective, IEEE Transactions on Industrial Informatics, vol. 14, no. 1, pp. 189-199, Jan. 2018.


clear;
format long;
load mavn_SYSdata;
load mavn_SRDdata1;
load mavn_SRDdata2;
load mavn_SRDdata3;

figure;
plot3(posx,posy,posz,'g--','linewidth',1);hold on;
for j=1:15:length(t)
    linksX=[0;0;j2px(j);j3px(j);j4px(j);j5px(j);posx(j)];
    linksY=[0;0;j2py(j);j3py(j);j4py(j);j5py(j);posy(j)];
    linksZ=[-0.2;0;j2pz(j);j3pz(j);j4pz(j);j5pz(j);posz(j)];
    plot3(linksX,linksY,linksZ,'k');hold on;
end
xlabel('X');ylabel('Y');zlabel('Z');
grid on;
set(gca,'drawmode','fast');

figure;
plot3(posx,posy,posz, 'LineWidth',2);hold on;
for j=1:length(t)
    basejoint1=line('xdata',[0;0],'ydata',[0;0],'zdata',[-0.2;0],...
        'color', 'yellow','erasemode','none');
    joints12=line('xdata',[0;j2px(j)],'ydata',[0;j2py(j)],'zdata',[0;j2pz(j)],...
        'color', 'red','erasemode','none');
    joints23=line('xdata',[j2px(j);j3px(j)],'ydata',[j2py(j);j3py(j)],'zdata',[j2pz(j);j3pz(j)],...
        'color', 'cyan','erasemode','none');
    joints34=line('xdata',[j3px(j);j4px(j)],'ydata',[j3py(j);j4py(j)],'zdata',[j3pz(j);j4pz(j)],...
        'color', 'magenta','erasemode','none');
    joints45=line('xdata',[j4px(j);j5px(j)],'ydata',[j4py(j);j5py(j)],'zdata',[j4pz(j);j5pz(j)],...
        'color', 'blue','erasemode','none');
    joints56=line('xdata',[j5px(j);posx(j)],'ydata',[j5py(j);posy(j)],'zdata',[j5pz(j);posz(j)],...
        'color', 'green','erasemode','none');
    drawnow
end
xlabel('X');ylabel('Y');zlabel('Z');
grid on;
