clc; clear all ;close all ;
clear all ;clear all ;
load mdl.mat

constants = init();
Ts=constants(7) ;
% hz=constants(12) ; 
llb=constants(18) ; uub=constants(19) ;
Tl = constants(23) ;
[Ad,Bd,Cd,Dd] = state_space() ;
all_hz = [];cost_sum=0; t=0;
% dwtmode('per','nodisplay');
trj_phi = trjGen2(1000);trj_t= 1:length(trj_phi) ;
trj = trj_phi(:,4);phi_ref = trj_phi(:,2);
loop_length=length(trj)-Tl;

states = [0;phi_ref(1);0;trj(1)] ;
loop_length=length(trj)-Tl;

for i = 1 : loop_length
    wavelet = wavedec(trj(i:i+Tl),3,'db2');
    curr_err = abs(states(4)-trj(i));
    curveture = calc_curv2(trj(i:i+Tl),Tl);

temp = [wavelet(1:27);wavelet(47:48);curveture;curr_err];
hzz = mdl.predictFcn(temp');
    hz = round( hzz );

all_hz = [all_hz;hz] ;
    lb = repmat(llb,hz,1);  ub = repmat(uub,hz,1);
    Y_goal=[];Z = zeros(hz,1);
     Color='g' ;
  
  for k=0:hz-1
  Y_goal = [Y_goal,0,phi_ref(i+k),0,trj(i+k)] ;
  end
[J,Hdb,ft] = new_Smp(Ad,Bd,hz,states,Y_goal,Z);

tic
%   [Z,cost] = quadprog( 2*Hdb,ft,[],[],[],[],lb,ub);
  [Z,cost] = fminimax(J,zeros(hz,1),[],[],[],[],lb,ub);
t=t+toc;
  cost_sum  = cost_sum+cost ;
  
 states = getStates(states,Z(1)) ;
 Y(i) = states(4);
    
 figure(1)
 plot(1:length(Y),Y,'LineWidth',2);
 hold on;plot(1:length(Y),trj(1:length(Y)));hold on;
hz
end 
 AVG_computationtime= t/i
 AVG_cost = cost_sum/i
 
 
 
 
 
 