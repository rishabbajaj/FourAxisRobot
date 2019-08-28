clc
clear
close all
%% 
close all
theta1rob = 10*pi/180;
theta2rob = 120*pi/180;
theta3rob = 60*pi/180;

theta1 = theta1rob + pi;
theta2 = -theta2rob+pi;
theta3 = -theta3rob + pi/2;
% theta1rob = theta1-pi;
% theta2rob = pi-theta2;
% theta3rob = theta3-pi/2;
pt1 = T01_func(9,theta1)
pt2 = T02_func(1.9,9,theta1,theta2)
pt3 = T03_func(1.9,10.5,9,theta1,theta2,theta3)
pt4 = T04_func(1.9,10.5,13.6,9,theta1,theta2,theta3)
finpts = [[0,0,0]' ,pt1(1:3,4) , pt2(1:3,4) ,pt3(1:3,4) ,pt4(1:3,4) ];
plot3(finpts(1,:),finpts(2,:), finpts(3,:) , 'k - ','LineWidth',10)
grid on
axis equal
pbaspect([1,1,1])
%% 
clc
a1=1.9;
a2=10.5;
a3 = 13.6;
dh1=9;
radius = 7;
theta = (0:5:360)*pi/180;
x = 20;
y = radius*sin(theta)+9;
z = radius*cos(theta)+10;
armVideo= VideoWriter('armVideo.avi');
open(armVideo);
% x = 15;
% y = 5;
% z = 12;
% x = [10,10,-10,-10,10];
% y = [12,-12,-12,12,12];
% z = [15,15,15,15,15]+10;
% t = 0:1:15;
% v = [0,0,1];

% x = x+v(1)*t;
% y = y+v(2)*t;
% z = z+v(3)*t;
k =1;
l = 1;
t1solve = theta1(x,y);
t2solve =  theta2(a1,a2,a3,dh1,t1solve(k,:),x,y,z);
t3solve = theta3(a1,a3,dh1,t1solve(k,:),t2solve(l,:),x,y,z);
% pt4 = T04_func(1.9,10.5,13.6,9,t1solve(2,5),t2solve(2,5),t3solve(5));
% pt4(1:3,4);
% pos1 = solx1(1.9,10.5,13.6,9, t1solve(1),pos(1,4),pos(2,4),pos(3,4))
% pos2 = solx2(1.9,13.6,9,t1solve(1), pos1(2),pos(1,4),pos(2,4),pos(3,4))
% plot3(x*ones(size(y)),y,z)
not = (imag(t3solve)==0);
t3solve = t3solve(not);
t2solve = t2solve(:,not);
t1solve = t1solve(:,not);
y  = y(not);
z = z(not);
% x = x(not);
figure
grid on
% t1solve = pi+t1solve*pi/180;
% t2solve = pi-t2solve*pi/180;
% t3solve = pi/2+t3solve*pi/180;

% hold on
% grid on
close all
% m = 1;
% t1solve=round(round(t1solve*180/pi/m)*m)*pi/180;
% t2solve=round(round(t2solve*180/pi/m)*m)*pi/180;
% t3solve=round(round(t3solve*180/pi/m)*m)*pi/180;
for j =1:2
for i = 1:length(t1solve)
pt1 = T01_func(dh1,t1solve(k,i));
pt2 = T02_func(a1,dh1,t1solve(k,i),t2solve(l,i));
pt3 = T03_func(a1,a2,dh1,t1solve(k,i),t2solve(l,i),t3solve(i));
pt4 = T04_func(a1,a2,a3,dh1,t1solve(k,i),t2solve(l,i),t3solve(i));
finpts = [[0,0,0]' ,pt1(1:3,4) , pt2(1:3,4) ,pt3(1:3,4) ,pt4(1:3,4) ];
% plot3(finpts(1,1:2),finpts(2,1:2), finpts(3,1:2) , ...
% finpts(1,2:3),finpts(2,2:3), finpts(3,2:3), ...
% finpts(1,3:4),finpts(2,3:4), finpts(3,3:4) , 'k - ','LineWidth',5, 'r - ','LineWidth',5, 'b - ','LineWidth',5);
% grid on
plot3(finpts(1,1:2),finpts(2,1:2), finpts(3,1:2),...
    finpts(1,2:3),finpts(2,2:3), finpts(3,2:3),...
    finpts(1,3:4),finpts(2,3:4), finpts(3,3:4),...
    finpts(1,4:5),finpts(2,4:5), finpts(3,4:5),'LineWidth',5);
% pt4(1,4) 
% axis equal



pbaspect([1,1,1])
xlabel('x-axis')
ylabel('y-axis')
zlabel('z-axis')
title('Robot animation')
grid on
hold on
plot3(x*ones(size(y)),y,z)
%  plot3(x,y,z)


hold off
axis([-10 30 -15 30 -30 40])
writeVideo(armVideo, getframe(gcf));

pause(0.01)

end
end
close(armVideo);
%%
close all
theta1_rob = t1solve(k,:)*180/pi-180;
theta2_rob = -t2solve(l,:)*180/pi+180;
theta3_rob = -t3solve(:)*180/pi+90;
plot(theta3_rob)
% plot(t3solve(:)*180/pi)
%%
theta1_rob = t1solve(k,:)*180/pi;
theta2_rob = t2solve(l,:)*180/pi;
theta3_rob = t3solve(:)*180/pi;
plot(theta3_rob)