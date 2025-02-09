function animateHW10(xout, dt)
% Do NOT modify this file
% xout: collection of state vectors at each time, output from ode45
% dt: (difference in time between each row of xout, generated by calling
% ode45 with the argument [tstart:dt:tfinal];)

% Define axis window
xmin = -3;
xmax = 3;
ymin = -1;
ymax = 5;

% Draw contact surfaces
x_a = linspace(xmin, xmax);
y_a = linspace(ymin, ymax);
[X,Y] = meshgrid(x_a,y_a);
a1 = Y;
a2 = X+Y+1;
a3 = (X-2).^2 + (Y-1).^2 - 2;
contour(X,Y,a1,[0,0], 'k'); hold on;
contour(X,Y,a2,[0,0], 'k'); hold on;
contour(X,Y,a3,[0,0], 'k')

% Create trace of trajectory and particle object
h = animatedline('LineStyle', ':', 'LineWidth', 1.5);
particle = [];

% Set up axes
axis equal
axis([xmin xmax ymin ymax])
xlabel('x')
ylabel('y')

% draw
for ii = 1:length(xout)
    a = tic;
    addpoints(h,xout(ii,1),xout(ii,2));
    drawnow limitrate
    delete(particle) % Erases previous particle
    particle = circles(xout(ii,1),xout(ii,2), 0.1, 'color', [1 0 0]);
    pause(dt - toc(a)); % waits if drawing frame took less time than anticipated
end
end