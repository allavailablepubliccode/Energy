clear;clc;close all;

Ar = 1:0.001:2;
wr = 0.2:0.001:0.3;
a = 0.08;

for ii = 1:numel(Ar)
    A = Ar(ii);

    for jj = 1:numel(wr)
        w = wr(jj);

        E(ii,jj) = (a*A^2/(pi*(a^2+w^2)^3))*(3*pi*w^4-4*w^3*a*sinh(2*a*pi/w)+2*pi*a^2*w^2-pi*a^4);

    end
end

imagesc(E)





