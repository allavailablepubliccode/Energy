clear;clc;close all;
addpath(genpath('~/Dropbox/BrainSpace/matlab/'))
dir1   = '/Users/erik/Library/CloudStorage/Dropbox/Least_Action/nullcorr/';
dir2   = '/Users/erik/Library/CloudStorage/Dropbox/Least_Action/null/';
dir3   = '/Users/erik/Library/CloudStorage/Dropbox/Least_Action/';

N  = 10000;

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

load([dir3 'Hmat.mat'],'H','sigcomp')
labeling = load_parcellation('schaefer',100);
energy_data = parcel2full(mean(H)',labeling.schaefer_100);

for ii = 1:numel(fezmaps)

    clear gldata
    load([dir2 num2str(N) '_' fezmaps{ii} '.mat'],'gldata');
    gldatafull = [gldata{1,1};gldata{1,2}];
    trucorr = corr(gldatafull,energy_data, 'rows','pairwise','type','spearman');

    clear nullcorr
    load([dir1 num2str(N) '_' fezmaps{ii} '.mat'],'nullcorr');
   
    siga = sort(nullcorr);
    c = max(find(trucorr>sort(nullcorr)));

    disp([fezmaps{ii} ' , p = ' num2str(1-(c/numel(siga)))])

end
