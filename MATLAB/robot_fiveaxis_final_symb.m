clc
clear
close all
syms a alpha theta d delta1 delta2 delta3 delta4 delta5 real 
t1 = sym(eye(4));
t1(3,4) = d;
t2 = sym(eye(4));
t2(1:2,1:2) = [cos(theta) , -sin(theta); sin(theta) , cos(theta)];
t3 = sym(eye(4));
t3(1,4) = a;
t4 = sym(eye(4));
t4(2:3,2:3) = [cos(alpha) , -sin(alpha); sin(alpha) , cos(alpha)];
syms theta1 h a1 a2 a3 a4 dh1 dh2 dh3 theta4 theta5 theta2 theta3 real
T = t4*t3*t2*t1;
T01 = subs(T,{a,alpha,theta,d},{0,0,theta1,10});
T12 = subs(T,{a,alpha,theta,d},{a1,pi/2,theta2,0});
T23 = subs(T,{a,alpha,theta,d},{a2,0,theta3,0});
T34 = subs(T,{a,alpha,theta,d},{a3,0,0,0});
% T45 = subs(T,{a,alpha,theta,d},{a4,delta5,theta5,1});
% T05= T01*T12*T23*T34*T45;
T05= T01*T12*T23*T34;
%% inverse kinematics - Equation 1
syms x y z real
Tend = sym(eye(4));
Tend(1:3,4) = [x;y;z];
m = (T01\Tend);
p = T01\T05;
b = simplify(p(:,4));
b = rewrite(b , 'tan' );
c =simplify(m(:,4));
c = rewrite(c,'tan');
eqn = (c(2)==b(2));
% fprintf('eqn3')
solx = solve(eqn,theta1);
solx = matlabFunction(solx)
%%  f = simplify(subs(solx,{x,y},{a1+a2+a3,0}));
k = (T01*T12)\Tend;
l = (T01*T12)\T05;
k(:,4)=simplify(k(:,4));
l(:,4)=simplify(l(:,4));
o = simplify(l(2,4));
%t= subs((k(1,4)-a2)^2 + k(2,4)^2,theta1,solx(1));
t= ((k(1,4)-a2)^2 + k(2,4)^2);
t =rewrite(t,'tan');
eqn2 = (t== simplify((l(1,4)-a2)^2 + l(2,4)^2));
solx1 = simplify(solve(eqn2,theta2));
solx1 = matlabFunction(solx1)
solx2 = asin(k(2,4)/a3);
solx2 = matlabFunction(solx2)
% solx1= subs(solx1, theta1, solx(1))
% solx2 = subs(solx2, [theta1, theta2], [solx(1),solx1(1)])
%% 
clc
pos = double(vpa(subs(T05, [a1,a2,a3, theta1,theta2,theta3] , [10,10,10,pi/7,pi/3,pi/12])))
t1solve = solx(pos(1,4),pos(2,4))
pos1 = solx1(10,10,10, t1solve(1),pos(1,4),pos(2,4),pos(3,4))
pos2 = solx2(10,10,t1solve(1), pos1(2),pos(1,4),pos(2,4),pos(3,4))
T01=matlabFunction(T01);
T02=matlabFunction(T01*T12);
T03=matlabFunction(T01*T12*T23);
T04=matlabFunction(T01*T12*T23*T34);
%% 
pt1=T01(0)
pt2 = T02(10,0,pi/2)
pt3 = T03(10,20,0,pi/2,pi/2)
pt4 = T04(10,20,10,0,pi/2,pi/2)
finpts = [[0,0,0]' ,pt1(1:3,4) , pt2(1:3,4) ,pt3(1:3,4) ,pt4(1:3,4) ];
plot3(finpts(1,:),finpts(2,:), finpts(3,:) , 'red - ','LineWidth',10)
grid on
axis equal