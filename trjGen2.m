function trj =trj_Gen2(length)
a = -pi/6;
b = pi/6;
r = (b-a).*rand(length,1) + a;
states = [0;0;0;0];
for loop = 1: length
states = getStates(states,r(loop)) ;
trj(loop,:) = states;
end
figure(1);plot(1:length,trj(:,4));
figure(2);plot(1:length,trj(:,2));
end