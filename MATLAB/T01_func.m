function T01 = T01_func(dh1,theta1)
%T01_FUNC
%    T01 = T01_FUNC(DH1,THETA1)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    08-Aug-2019 12:24:02

t2 = sin(theta1);
t3 = cos(theta1);
T01 = reshape([t3,t2,0.0,0.0,-t2,t3,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,dh1,1.0],[4,4]);
