clear;clc;close all;

a = -0.4;
c0 = 2;
c1 = 4;

t = 0:0.001:2;

x = c0*exp(-a*t);
xtilda = c1*exp(a*t);

E = - a * x .* xtilda;

figure
plot(x,'k','LineWidth',3)
hold on
plot(xtilda,'k--','LineWidth',3)
plot(E,'r','LineWidth',3)
hold off
axis tight