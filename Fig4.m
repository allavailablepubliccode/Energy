clear;clc;close all;

a           = -0.1; 
b           = 1; 
u           = @(t) sin(t); 

odef        = @(t, x) -a*x + b*u(t);
odef_mir    = @(t, x_mirror) a*x_mirror - b*u(t);

t           = [0 2*pi];

x_0         = 0;

[t, x]      = ode45(odef, t, x_0);
[t, x_mir]  = ode45(odef_mir, t, x_0);

u_values = arrayfun(u, t);

E = a*x.*x_mir - b*u_values.*(x+x_mir);

figure;
plot(t, x, 'k','LineWidth',3)
hold on
plot(t, x_mir, 'k--','LineWidth',3)
plot(t, E, 'r','LineWidth',3)
hold off
axis tight
