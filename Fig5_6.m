clear;clc;close all;
addpath(genpath('/Users/erik/Library/CloudStorage/Dropbox/Work/BrainSpace/'))
dir   = '/Users/erik/Library/CloudStorage/Dropbox/Work/Least_Action/';
load([dir 'Hmat.mat'],'H')
[surf_lh, surf_rh] = load_conte69();
labeling           = load_parcellation('schaefer',100);
plot_hemispheres(mean(H)', {surf_lh,surf_rh},'parcellation',labeling.schaefer_100,'views','ms');
view(0,90)

