function constants = init()
m= 1500 ; %1
Iz= 3000 ; %2
Caf= 19000 ; %3
Car= 33000 ; %4
lf= 2 ; %5
lr= 3 ; %6
Ts= 0.01 ; %7

q= 100 ; % 8
s= 0 ; %9
r= .01 ; % 10

outputs= 1 ; % 11   % number of outputs (psi, Y)
hz = 25 ; % 12
x_dot= 10 ; % 13
lane_width= 7 ;% 14 [m]

rad= 4 ; % 15
f= .01; %15
time_length = 10 ;% 17  %[s] - duration of the entire manoe

lb = -pi/6 ; % 18  
ub = pi/6 ;  % 19
trajectory = 3; %20
amp = 1 ;  %21
p=5;%22
Tl = 40 ;
NumOfStates = 4;
constants=[m,Iz,Caf,Car,lf,lr,Ts,q,s,r,outputs,hz,x_dot,lane_width,rad,f, ...
    time_length,lb,ub,trajectory,amp,p,Tl,NumOfStates] ;
end