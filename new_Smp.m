function[J,Hdb,Fdbt] = new_Smp(Ad,Bd,hz,X0,Y_goal,U_goal)
constants = init();
 q = constants(8) ;
 S = constants(9) ;
 R = constants(10) ; 
 outputs=constants(11) ; 
 Q = [ 0,0,0,0; 0,0,0,0; 0,0,0,0; 0,0,0,q ];
 Q_big = kron(eye(hz),Q);
 R_big = R*ones((hz*outputs));
 
 S = zeros(hz*length(Ad),hz*1) ;
 v = zeros(length(Ad)*hz,1) ;

 for i = 1:hz
   for j=1:hz
    if j<=i
     S(1+length(Bd(:,1))*(i-1):length(Bd(:,1))*i,1+length(Bd(1,:))*(j-1):length(Bd(1,:))*j)=Ad^(i-j)*Bd;
    end
   end
   v((1+(i-1)*length(Ad)):(i*length(Ad)) )= Ad^(i)*X0 ;
 end
 
Hdb=S'*Q_big*S+R_big ;
% U_goal=0; 
Fdbt = S'*Q_big*v - S'*Q_big*Y_goal'- R_big*U_goal ;
J = @(z) (S*z+v-Y_goal')'*Q_big*(S*z+v-Y_goal') + (z-U_goal)'*R_big*(z-U_goal);
end