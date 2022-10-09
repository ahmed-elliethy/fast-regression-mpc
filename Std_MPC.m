clc; clear all ;
load trj.mat
constants = init();
Ts=constants(7) ;
hz=40 ; 
llb=constants(18) ; uub=constants(19) ;Tl = constants(23) ;
[Ad,Bd,Cd,Dd] = state_space() ;
all_hz = [];cost_sum=0; t=0;
% trj_phi = trjGen2(1000);trj_t= 1:length(trj_phi) ;
trj = trj_phi(:,4);phi_ref = trj_phi(:,2);
loop_length=length(trj)-Tl;
lb = repmat(llb,hz,1);  ub = repmat(uub,hz,1);

states = [0;phi_ref(1);0;trj(1)] ;
for i = 1 : loop_length
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
    
 figure(2)
set(gcf,'name','std-MPC','numbertitle','off')
 plot(1:length(Y),trj(1:length(Y)));hold on;
 plot(1:length(Y),Y,'LineWidth',2);hold on;
 legend('Ref','Actual','FontSize',16);
hz
end 
 AVG_computationtime= t/i
 AVG_cost = cost_sum/i
 str = sprintf(' Avg. computation time = %d, AVG. cost = %d ', AVG_computationtime,AVG_cost);
 title(str,'FontSize',20);