clear;clc;close all;

% Created by Eugene M. Izhikevich, February 25, 2003
% Excitatory neurons    Inhibitory neurons
Ne=800;                 Ni=200;
re=rand(Ne,1);          ri=rand(Ni,1);
a=[0.02*ones(Ne,1);     0.02+0.08*ri];
b=[0.2*ones(Ne,1);      0.25-0.05*ri];
c=[-65+15*re.^2;        -65*ones(Ni,1)];
d=[8-6*re.^2;           2*ones(Ni,1)];
S=[0.5*rand(Ne+Ni,Ne),  -rand(Ne+Ni,Ni)];

v=-65*ones(Ne+Ni,1);    % Initial values of v
u=b.*v;                 % Initial values of u
firings=[];             % spike timings

for t=1:1000            % simulation of 1000 ms
  I=[5*randn(Ne,1);2*randn(Ni,1)]; % thalamic input
  fired=find(v>=30);    % indices of spikes
  firings=[firings; t+0*fired,fired];
  v(fired)=c(fired);
  u(fired)=u(fired)+d(fired);
  I=I+sum(S(:,fired),2);
  v=v+0.5*(0.04*v.^2+5*v+140-u+I); % step 0.5 ms
  v=v+0.5*(0.04*v.^2+5*v+140-u+I); % for numerical
  u=u+a.*(b.*v-u);                 % stability
end

for tt = 1:1000
    a = find(firings(:,1)==tt);
    b = firings(a,2);
    E = b;
    E(E>800) = [];
    E = numel(E);
    Exc(tt) = E;
end

LAP = inv(Exc');

x = LAP.Y;
xs = x(end:-1:1);

a = LAP.qP.P{1}.a;
b = LAP.qP.P{1}.b;
u = LAP.qU.v{1,2};

H = a*x.*xs - b*u.*(x+xs);
plot(H,'k')

function LAP = inv(Y)

        % model states (initial conditions)
        %--------------------------------------------------------------------------
        x.x         = 0;                      % amplitude

        % model parameters (prior means)
        %--------------------------------------------------------------------------
        P.a         = 0;        % internal coupling
        P.b         = 0;        % external coupling
        P.s         = 0;        % scaling

        % prior variance
        %--------------------------------------------------------------------------
        pC.a         = 1;
        pC.b         = 1;
        pC.s         = 1;

        % observation function (to generate timeseries)
        %--------------------------------------------------------------------------
        g           = @(x,v,P) P.s*x.x;

        % equation of motion (control theory LTI)
        %--------------------------------------------------------------------------
        f           = @(x,v,P) P.a*x.x + P.b*v;

        % first level state space model
        %--------------------------------------------------------------------------
        DEM.M(1).x      = x;                             % initial states
        DEM.M(1).f      = f;                             % equations of motionDEM.
        DEM.M(1).g      = g;                             % observation mapping
        DEM.M(1).pE     = P;                             % model parameters
        DEM.M(1).pC     = diag(spm_vec(pC));
        DEM.M(1).V      = exp(16);                       % precision of observation noise
        DEM.M(1).W      = exp(16);                       % precision of state noise

        % second level  causes or exogenous forcing term
        %--------------------------------------------------------------------------
        DEM.M(2).v      = 0;                             % initial causes
        DEM.M(2).V      = exp(16);                       % precision of exogenous causes

        % create data with known parameters (P)
        %==========================================================================
        DEM.U = (rand(size(Y'))-0.5)/16;        % randomized driving input
        DEM.Y = Y';

        LAP   = spm_LAP(DEM);

end
