function CreateRegularShifts(LRImagePath,RegSSImagesPath)
%%
% This function creates regular shifts along 3 axes
% Author:
%  	Karl Thurnhofer Hemsi
%   Department of Computer Languages and Computer Sciences
%   University of Málaga (Spain)

%%
rng('default')

[~,name,ext]=fileparts(LRImagePath);

fprintf('Creating regular shifts for image %s\n',name);

V = niftiread(LRImagePath);

% Model parameters
NumShifts = 47;
ShiftDims = zeros(NumShifts,3);
RangeDims = 0:3:3*(NumShifts-1);


NdxShift = 1;
for NdxRange = RangeDims
    
    % Three dimensions
    ShiftDims(NdxShift,:) = [NdxRange NdxRange NdxRange];
    ShiftedImage = circshift(V,ShiftDims(NdxShift,:));
    outfile = sprintf('%s/%s_Shifted_%d%s',RegSSImagesPath,name,NdxShift,ext);
    niftiwrite(ShiftedImage,outfile);
    NdxShift = NdxShift+1;

end
save(sprintf('%s/%s_GridShiftDims.mat',RegSSImagesPath,name),'ShiftDims');
    
end

