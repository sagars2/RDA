function [CM] = compFA(x,contactMode)

% Compute reset map into mode
[A0,A1,A2,A3] = A_mat(x);
[dA0,dA1,dA2,dA3] = dA_mat(x);
[dq_plus,p_hat] = resetMap(x,contactMode);
% [dynamicsreturn] = Dynamics(t,x,contactMode);

m = 1;
g = 9.8;
M = [m 0;0 m];
N = [0;m*g];
x_4 = x(1);
y_4 = x(2);
dx_4 = x(3);
dy_4 = x(4);
q_dot4 = [dx_4;dy_4];
x_p4 = [x_4;y_4;dx_4; dy_4];

tolerance = 0.1;
t = 0;
if isequal(contactMode,[])
    ddq = inv(M)*(-N);
    ddx = ddq(1);
    ddy = 0;
    lambda = ddq(2);

elseif isequal(contactMode,[1])
    block = inv([M A1';A1 zeros(1,1)]);
    qddl = block*[-N;-dA1*q_dot4];
    lambda = [qddl(3)];
    ddx = qddl(1);
    ddy = qddl(2);
elseif isequal(contactMode,[2])
    block = inv([M A2.';A2 zeros(1,1)]);
    qddl = block*[-N;-dA2*q_dot4];
    lambda = [qddl(3)];
    ddx = qddl(1);
    ddy = qddl(2);
elseif isequal(contactMode,[3])
    block = inv([M A3.';A3 zeros(1,1)]);
    qddl = block*[-N;-dA3*q_dot4];
    lambda = [qddl(3)];
    ddx = qddl(1);
    ddy = qddl(2);

elseif isequal(contactMode,[1,3]) || isequal(contactMode,[3,1])
    block = inv([M A13.';A13 zeros(2)]);
    qddl = block*[-N;-dA13*q_dot4];
    lambda = [qddl(3)];
    ddx = qddl(1);
    ddy = qddl(2);

end
% Generate complementarity conditions
 if -lambda>=tolerance && A3*[ddx;ddy]+dA3*[dx_4;dy_4]<tolerance
     CM = contactMode;
 else
     CM = [];
% If both complementarity conditions are satisfied, switch modes
     
 end