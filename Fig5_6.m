clear;clc;close all;
addpath(genpath('~/Dropbox/BrainSpace/matlab/'))
dir   = '/Users/erik/Library/CloudStorage/Dropbox/Least_Action/';
load([dir 'Hmat.mat'],'H')
[surf_lh, surf_rh] = load_conte69();
labeling           = load_parcellation('schaefer',100);
plot_hemispheres(mean(H)', {surf_lh,surf_rh},'parcellation',labeling.schaefer_100,'views','ms');
colormap gray
view(-90,0)
colorbar
