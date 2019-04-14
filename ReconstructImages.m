function ReconstructImages(imagePath,imageName,RegSSDimPath,SRImagesPath,ZoomFactor)
%%
% This script executes RegSS-SRCNN3D method and compute quality measures
% Author:
%  	Karl Thurnhofer Hemsi
%   Department of Computer Languages and Computer Sciences
%   University of Málaga (Spain)


fprintf('Reconstructing image %s\n',imageName);

%% Load HR and LR images
originalfile = sprintf('%s/%s.nii',imagePath,imageName);
if exist(originalfile,'file')
    HR = double(niftiread(originalfile));
    maxValue = max(HR(:));
    HR = HR/maxValue;
end

if (~contains(imageName,'_LR'))
    LRfile = sprintf('%s/%s_LR.nii',imagePath,imageName);
else
    LRfile = sprintf('%s/%s.nii',imagePath,imageName);
end
LRimage = double(niftiread(LRfile));
sizLR = size(LRimage);

ResultsFileName = sprintf('%s/%s_Results.mat',imagePath,imageName);
if exist(ResultsFileName,'file')
    load(ResultsFileName)
end

%% Execute reconstruction
RestoredImage = SRCNN3D_RegSS(RegSSDimPath,SRImagesPath,imageName,ZoomFactor,sizLR*ZoomFactor);
fprintf('Done!\n');

%% Compute quality metrics
if exist(originalfile,'file')
    fprintf('Calculating quality measures...\n');
    Quality=RestorationQuality(255*HR,255*RestoredImage);
    Results.MSE=Quality.MSE;
    Results.RMSE=Quality.RMSE;
    Results.PSNR=Quality.PSNR;
    Results.SNR=Quality.SNR;
    Results.MatlabSSIM=Quality.SSIM;
    Results.BC=Quality.BC;

    fprintf('Results for image %s and ZoomFactor = %g:\n',...
        imageName,ZoomFactor);
    fprintf('MSE: %d\n',Quality.MSE);
    fprintf('SSIM: %d\n',Quality.SSIM);
    fprintf('BC: %d\n',Quality.BC);
    fprintf('PSNR: %d\n',Quality.PSNR);
    fprintf('SNR: %d\n',Quality.SNR);
end

RestoredImage_uint8=uint8(RestoredImage*255);

Results.RestoredImage=RestoredImage_uint8;
save(ResultsFileName,'Results','ZoomFactor');

