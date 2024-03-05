clear;clc;close all;
addpath(genpath('~/Dropbox/BrainSpace/matlab/'))
load('/Users/erik/Library/CloudStorage/Dropbox/Least_Action/null/10000_cmruglu.mat','gldata')
gldatafull = [gldata{1,1};gldata{1,2}];
labeling           = load_parcellation('schaefer',100);

% ask fez
fez_data            = full2parcel(gldatafull',labeling.schaefer_100);

[surf_lh, surf_rh] = load_conte69();
plot_hemispheres(fez_data, {surf_lh,surf_rh},'parcellation',labeling.schaefer_100,'views','ms');
colormap gray
view(-90,0)
% colorbar



