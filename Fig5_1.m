clear;clc;close all;

indir = '/Users/erik/Library/CloudStorage/Dropbox/hcp_rest/hcp_rest_schaeffer/';
outdir = '/Users/erik/Library/CloudStorage/Dropbox/Least_Action/dat/';

files = {
'154734';
'100307';
'100408';
'101107';
'101309';
'101915';
'103111';
'103414';
'103818';
'105014';
'105115';
'106016';
'108828';
'110411';
'111312';
'111716';
'113619';
'113922';
'114419';
'116524';
'117122';
'118528';
'118730';
'118932';
'120111';
'122317';
'122620';
'123117';
'123925';
'124422';
'125525';
'126325';
'127630';
'127933';
'128127';
'128632';
'129028';
'130013';
'130316';
'131217';
'131722';
'133019';
'133928';
'135225';
'135932';
'136833';
'138534';
'139637';
'140925';
'144832';
'146432';
'147737';
'148335';
'148840';
'149337';
'149539';
'149741';
'151526';
'151627';
'153025';
'156637';
'159340';
'160123';
'161731';
'162733';
'163129';
'176542';
'178950';
'188347';
'189450';
'190031';
'192540';
'198451';
'199655';
'201111';
'208226';
'211417';
'211720';
'212318';
'214423';
'221319';
'239944';
'245333';
'280739';
'298051';
'366446';
'397760';
'414229';
'499566';
'654754';
'672756';
'751348';
'756055';
'792564';
'856766';
'857263';
'899885'};

for ii = 1:numel(files)

    a = importdata([indir files{ii} '.txt']);

    clear LAP
    for jj = 1:size(a,2)
        jj
        LAP{jj} = inv(a(:,jj));
    end

    save([outdir files{ii} '.mat'],'LAP')
end


function LAP = inv(Y)

% model states (where hidden states comprise phase differences)
%--------------------------------------------------------------------------
x.x         = 0;                      % amplitude

% model parameters
%--------------------------------------------------------------------------
P.a         = 0;
P.b         = 0;
P.s         = 1;

% prior variance
%--------------------------------------------------------------------------
pC.a         = 1;
pC.b         = 1;
pC.s         = 1;

% observation function (to generate timeseries)
%--------------------------------------------------------------------------
g           = @(x,v,P) P.s*x.x;

% equations of motion (simplified coupled oscillator model)
%--------------------------------------------------------------------------
f           = @(x,v,P) P.a*x.x + P.b*v;

% first level state space model
%--------------------------------------------------------------------------
DEM.M(1).x      = x;                             % initial states
DEM.M(1).f      = f;                             % equations of motionDEM.
DEM.M(1).g      = g;                             % observation mapping
DEM.M(1).pE     = P;                             % model parameters
DEM.M(1).pC     = diag(spm_vec(pC));
DEM.M(1).V      = exp(4);                       % precision of observation noise
DEM.M(1).W      = exp(4);                       % precision of state noise

% second level  causes or exogenous forcing term
%--------------------------------------------------------------------------
DEM.M(2).v      = 0;                             % initial causes
DEM.M(2).V      = exp(4);                       % precision of exogenous causes

% create data with known parameters (P)
%==========================================================================
DEM.U = (rand(size(Y'))-0.5)/16;
DEM.Y = Y';

LAP   = spm_LAP(DEM);

end