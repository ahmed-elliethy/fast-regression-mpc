function [Ad,Bd,Cd,Dd] =state_space()
constants = init();
m=constants(1) ;
m= 1.2*m;
Iz=constants(2) ;
Caf=constants(3) ;
Caf = 1.2*Caf ;
Car=constants(4) ;
lf=constants(5) ;
lr=constants(6) ;
Ts=constants(7) ;
outputs=constants(11) ; 
x_dot=constants(13) ;

        A1=-(2*Caf+2*Car)/(m*x_dot) ;
        A2=-x_dot-(2*Caf*lf-2*Car*lr)/(m*x_dot) ;
        A3=-(2*lf*Caf-2*lr*Car)/(Iz*x_dot) ;
        A4=-(2*lf^2*Caf+2*lr^2*Car)/(Iz*x_dot) ;

        A= [ A1, 0, A2, 0 ; 0, 0, 1, 0 ; A3, 0, A4, 0 ; 1, x_dot, 0, 0 ] ;
        B= [ 2*Caf/m ; 0 ; 2*lf*Caf/Iz ; 0 ] ;
        if (outputs == 1)
          C= [ 0, 0, 0, 1 ] ;
        elseif (outputs == 2)
          C= [0, 1, 0, 0  ; 0, 0, 0, 1 ] ;
        end
        D=0 ;

%         % Discretise the system (forward Euler)
%         Ad=eye(size(A))+Ts*A ;
%         Bd=Ts*B ;
%         Cd=C ;
%         Dd=D ;
        
 sysc=ss (A, B ,C,D) ;
 sysd=c2d(sysc,Ts,'zoh') ;
 Ad=sysd.A;
 Bd=sysd.B ;
 Cd=sysd.C;
 Dd=sysd.D;

end