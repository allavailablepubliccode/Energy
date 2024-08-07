clear;clc;close all;
addpath(genpath('~/Dropbox/BrainSpace/matlab/'))
nulldir   = '/Users/erik/Library/CloudStorage/Dropbox/Least_Action/null/';
outdir   = '/Users/erik/Library/CloudStorage/Dropbox/Least_Action/nullcorr/';
Hdir = '/Users/erik/Library/CloudStorage/Dropbox/Least_Action/';
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

load([Hdir 'Hmat.mat'],'H','sigcomp')
labeling                = load_parcellation('schaefer',100);
energy_data = parcel2full(mean(H)',labeling.schaefer_100);

for ii = 1:numel(fezmaps)

    clear null_data gldata null_data_full gldatafull trucorr nullcorr
    load([nulldir num2str(N) '_' fezmaps{ii} '.mat'],'gldata','null_data');
    null_data_full = [squeeze(null_data{1,1});squeeze(null_data{2,1})];

    for kk = 1:size(null_data_full,2)
        nullcorr(kk) = corr(null_data_full(:,kk),energy_data, 'rows','pairwise','type','spearman');
    end
    save([outdir num2str(N) '_' fezmaps{ii} '.mat'],'nullcorr')

end
