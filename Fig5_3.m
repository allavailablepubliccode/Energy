clear;clc;close all;
indir = '/Users/erik/Library/CloudStorage/Dropbox/Least_Action/dat/';
outdir = '/Users/erik/Library/CloudStorage/Dropbox/Least_Action/';

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
 
c = 0;
for ii = 1:numel(files)
    ii

    if ~exist([indir files{ii} '.mat'])
        continue
    else
        c = c+ 1;

        clear LAP
        load([indir files{ii}],'LAP')

        for jj = 1:numel(LAP)

            temp = LAP{jj};

            x = temp.Y;
            xs = x(end:-1:1);

            a = temp.qP.P{1}.a;
            b = temp.qP.P{1}.b;
            u = temp.qU.v{1,2};

            H(c,jj) = mean(a*x.*xs - b*u.*(x+xs));

            sigcomp(c,jj) = mean(normalize(x,'range'));

        end
    end
end
save([outdir 'Hmat.mat'],'H','sigcomp')
