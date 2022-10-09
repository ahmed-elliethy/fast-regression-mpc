function new_states = getStates(states,U1)
constants = init();
m=constants(1) ;
Iz=constants(2) ;
Caf=constants(3) ;
Car=constants(4) ;
lf=constants(5) ;
lr=constants(6) ;
Ts=constants(7) ;
x_dot=constants(13) ;

        current_states=states ;
        new_states=current_states ;
        
        y_dot=current_states(1) ;
        psi=current_states(2) ;
        psi_dot=current_states(3) ;
        Y=current_states(4) ;

        sub_loop=30;  %Chop Ts into 30 pieces
        for i = 0 : sub_loop
            % Compute the the derivatives of the states
            y_dot_dot=-(2*Caf+2*Car)/(m*x_dot)*y_dot+(-x_dot-(2*Caf*lf-2*Car*lr)/(m*x_dot))*psi_dot+2*Caf/m*U1 ;
            psi_dot=psi_dot ;
            psi_dot_dot=-(2*lf*Caf-2*lr*Car)/(Iz*x_dot)*y_dot-(2*lf^2*Caf+2*lr^2*Car)/(Iz*x_dot)*psi_dot+2*lf*Caf/Iz*U1 ;
            Y_dot=sin(psi)*x_dot+cos(psi)*y_dot ;

            % Update the state values with new state derivatives
            y_dot=y_dot+y_dot_dot*Ts/sub_loop ;
            psi=psi+psi_dot*Ts/sub_loop ;
            psi_dot=psi_dot+psi_dot_dot*Ts/sub_loop ;
            Y=Y+Y_dot*Ts/sub_loop ;
        end
        % Take the last states
        new_states(1)=y_dot ;
        new_states(2)=psi ;
        new_states(3)=psi_dot ;
        new_states(4)=Y ;

end