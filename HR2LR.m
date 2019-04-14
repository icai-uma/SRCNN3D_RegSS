function HR2LR(imagePath,ZoomFactor)
%%
% This function creates a LR image froma HR one
% Author:
%  	Karl Thurnhofer Hemsi
%   Department of Computer Languages and Computer Sciences
%   University of Málaga (Spain)

%%
[pathstr,name,ext]=fileparts(imagePath);

fprintf('Downsampling image %s\n',name);

infile = imagePath;
V = niftiread(infile);
[x,y,z] = size(V);
disp(['Size of input image: ',num2str([x y z])]);
V = V(1:x-mod(x,ZoomFactor),1:y-mod(y,ZoomFactor),1:z-mod(z,ZoomFactor));
disp(['Size of cropped image: ',num2str(size(V))]);
VG = imgaussfilt3(V,1);
VN = imresize3(VG,1/ZoomFactor);
disp(['Size of downsampled image: ',num2str(size(VN))]);
outfile = fullfile(pathstr,sprintf('%s_LR%s',name,ext));
niftiwrite(VN,outfile);
    
