clear;clc;close all;
addpath(genpath('~/Dropbox/BrainSpace/matlab/'))
[sphere_lh, sphere_rh]  = load_conte69('spheres');
spheres                 = {sphere_lh,sphere_rh};
fezdir                  = '/Users/erik/Library/CloudStorage/Dropbox/Least_Action/code/ForErik/';
outdir                  = '/Users/erik/Library/CloudStorage/Dropbox/Least_Action/null/';
N                       = 10000;

fezmaps = {'cmr02';
    'cmruglu';
    'cbf';
    'cbv';
    'margulies01';
    'margulies02';
    'margulies03';
    'megalpha';
    'megbeta';
    'megdelta';
    'meggamma1';
    'meggamma2';
    'megtheta';
    'megtimescale';
    'myelinmap';
    'thickness'};

for ii = 1:numel(fezmaps)
    ii

    clear g_l g_r gldata null_data
    g_l         = gifti([fezdir fezmaps{ii} '_L.gii']);
    g_r         = gifti([fezdir fezmaps{ii} '_R.gii']);
    gldata      = {g_l.cdata,g_r.cdata};
    null_data   = spin_permutations(gldata,spheres,N);

    save([outdir num2str(N) '_' fezmaps{ii} '.mat'],'g_l','g_r','gldata','null_data','-v7.3');

end
