%%%%%%%%%%%%%%%%%%%%
%%% Coh & Purity
%%% 2019/10/08
%%%%%%%%%%%%%%%%%%%%

addpath(genpath('D:\\Software\\QElab\\QETLAB-0.9'))
dim = 2;
num =10^4;

cc = [];
purity = [];

load('E:\\06_Coh\\00_Code\\00_dim2gs\\00_data\\a0_20191012_rho2_10000.mat','rho')

for i = 1:num
    rhotmp = rho(:,:,i);
    cctmp = CoherenceWeight(rhotmp);
    pptmp = Purity(rhotmp);
    cc = cat(1, cc, cctmp);
    purity = cat(1, purity, pptmp);
    i
end
save('E:\\06_Coh\\00_Code\\00_dim2gs\\00_data\\a0_20191012_cc_10000.mat','cc')
save('E:\\06_Coh\\00_Code\\00_dim2gs\\00_data\\a0_20191012_purity_10000.mat','purity')
