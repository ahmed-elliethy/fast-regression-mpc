function [trj]=trj_Gen(trajectory,xxx,yyy)
 constants = init();
 Ts=constants(7) ;
 x_dot=constants(13) ;
 r=constants(15) ;
 f=constants(16) ; 
 time_length=constants(17) ;
 t=0:Ts:time_length;

 lane_width=constants(14) ; 
 trj=[];
 
 a=10;b=50;
 x= linspace(0,x_dot*t(end),length(t));
 if trajectory==1
    trj=-9*ones(length(t));
 elseif trajectory==2
    trj=9*tanh(t-time_length/2);
    
 elseif trajectory==3
    aaa=-28/100^2;
    aaa=aaa/1.1;
    if aaa<0
         bbb=xxx;
    else
         bbb=-xxx;
    end
    y_1=aaa*(x+lane_width-100).^2+bbb;
    y_2=2*r*sin(2*pi*(yyy/10)*f*x);
    trj=(y_1+y_2)/2;
    
 elseif trajectory==4
    for t=0:Ts:time_length
          trj = [trj , t  ] ;
    end
 elseif trajectory==5
    for t=0:Ts:time_length/4-Ts
      trj = [trj , sin(2*pi*a*f*t)  ] ;
    end
    for t=time_length/4:Ts:3*time_length/4-Ts
      trj_diff= sin(2*pi*b*f*t) - (sin(2*pi*b*f*time_length/4) - sin(2*pi*a*f*(time_length/4-Ts)) );
      trj = [trj ,  trj_diff] ;
    end
    for t=3*time_length/4-Ts-Ts:Ts:time_length
     trj = [trj , t-(t- trj_diff) ] ;
    end
    trj = .5*trj;
 end
end