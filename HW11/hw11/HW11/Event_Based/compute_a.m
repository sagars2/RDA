function a = compute_a(in1)
%COMPUTE_A
%    A = COMPUTE_A(IN1)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    04-Nov-2019 15:37:45

x = in1(1,:);
y = in1(2,:);
a = [2*y-x;2*y+x];
