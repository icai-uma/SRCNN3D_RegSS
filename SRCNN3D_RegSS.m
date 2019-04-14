function RestoredImage = SRCNN3D_RegSS(dimspathfile,path,image,ZoomFactor,sizHR)
%%
% This function computes the super-resoluted image using the shifted SR
% images
% Author:
%  	Karl Thurnhofer Hemsi
%   Department of Computer Languages and Computer Sciences
%   University of Málaga (Spain)

%%
load(sprintf('%s/%s_LR_GridShiftDims.mat',dimspathfile,image),'ShiftDims')
ShiftDims = -ZoomFactor*ShiftDims;


NumShifts = 47;
UnshiftedImage = zeros([sizHR NumShifts]);


for NdxShift = 1:NumShifts

    infile = sprintf('%s/%s_LR_Shifted_%d_SRCNN3D.nii',path,image,NdxShift);
    V = double(niftiread(infile));
    V = V/max(max(max(V)));
    
    UnshiftedImage(:,:,:,NdxShift) = circshift(V,ShiftDims(NdxShift,:));

end

RestoredImage = mean(UnshiftedImage,4);
