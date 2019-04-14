function [Results]=RestorationQuality(OrigImg,RestoredImg)
% Computes restoration quality measures for images in the [0,255] range, as in:
% C.S. Anand, J.S. Sahambi / Magnetic Resonance Imaging 28 (2010) 842-861

PlainErrors=(OrigImg-RestoredImg);

% Mean Squared Error (MSE)
Results.MSE=mean(PlainErrors(:).^2);

% Root Mean Squared Error (RMSE)
Results.RMSE=sqrt(Results.MSE);

% Power Signal-to-Noise Ratio (PSNR)
Results.PSNR=10*log10((255^2)/Results.MSE);

% Signal-to-Noise Ratio (SNR)
Results.SNR = 10*log10(mean(OrigImg(:).^2)/Results.MSE);

% Structural Similarity Index (SSIM)
Results.SSIM = ssim(OrigImg/255,RestoredImg/255);

% Bhattacharrya coefficient (BC)
HistOrig=histc(OrigImg(:),0:256);
HistOrig=HistOrig/sum(HistOrig);
HistRestored=histc(RestoredImg(:),0:256);
HistRestored=HistRestored/sum(HistRestored);
Results.BC=sum(sqrt(HistOrig.*HistRestored));



