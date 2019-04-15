**Super-resolution of 3D MRI images by regular random shifting**

SRCNN3D+RegSS
---
This code executes the SRCNN3D+RegSS method for a set of input images

## Pre-requisites

- The **SRCNN3D** method must be installed in the system. Please, follow instalation instructions from [here](https://github.com/rousseau/deepBrain/tree/master/SRCNN3D).
- Matlab (tested on v2018b or earlier). Deep learning toolbox is required to execute VDSR competing method.
---

## Set up

1. Open Demo_SRCNN3D_RegSS.sh.
2. Set the appropiate paths.
3. Set the desired ZoomFactor value.
4. The folder 'Images' should sotre those images that are going to be reconstructed.
There are two options mutually compatibles:
- Use HR images as the input. In this case, the HR will be downsampled using ZoomFactor  and the resulting LR image will be processed. Finally, quality measures are displayed.
- Use LR as input. Quality won't be displayed as there is not a HR reference image.
---

## Run
Run Demo_SRCNN3D_RegSS.sh in a bash shell. If a Conda environment is used, please activate it 
before launch the script.