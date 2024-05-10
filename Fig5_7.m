clear;clc;close all;
addpath(genpath('~/Dropbox/BrainSpace/matlab/'))
dir   = '/Users/erik/Library/CloudStorage/Dropbox/Work/Least_Action/';
load([dir 'Hmat.mat'],'H')
[surf_lh, surf_rh] = load_conte69();
labeling           = load_parcellation('schaefer',100);

load('/Users/erik/Library/CloudStorage/Dropbox/Work/Least_Action/null/10000_cmruglu.mat','gldata')
gldatafull = [gldata{1,1};gldata{1,2}];
fez_data            = full2parcel(gldatafull',labeling.schaefer_100);

plot(fez_data,mean(H)','o')
