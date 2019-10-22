addpath(genpath('D:\\Software\\QElab\\QETLAB-0.9'))


dim = 2;
num = 10^4;
rho = [];
for k = 1:num
    rho(:,:,k) = RandomDensityMatrix(dim, 0, dim, 'haar'); % http://www.qetlab.com/RandomDensityMatrix
end

save('E:\\06_Coh\\00_Code\\00_dim2gs\\00_data\\a0_20191012_rho2_10000.mat','rho')