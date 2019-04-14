**Super-resolution of 3D MRI images by regular random shifting: SRCNN3D+RegSS**

This code executes the RegSS-SRCNN3D method for a set of input images
---

## Pre-requisites

- The **SRCNN3D** method must be installed in the system. Please, follow instalation instructions from [here](https://github.com/rousseau/deepBrain/tree/master/SRCNN3D).
- Matlab (tested on v2018b or earlier). Deep learning toolbox is required to execute VDSR competing method.
---

## Set up

1. Open Demo_RegSS-SRCNN3D.sh.
2. Set the appropiate paths.
3. Set the desired ZoomFactor value.
4. The folder 'Images' should sotre those images that are going to be reconstructed.
There are two options mutually compatibles:
- Use HR images as the input. In this case, the HR will be downsampled using ZoomFactor  and the resulting LR image will be processed. Finally, quality measures are displayed.
- Use LR as input. Quality won't be displayed as there is not a HR reference image.
---

## Create a file

Next, you’ll add a new file to this repository.

1. Click the **New file** button at the top of the **Source** page.
2. Give the file a filename of **contributors.txt**.
3. Enter your name in the empty file space.
4. Click **Commit** and then **Commit** again in the dialog.
5. Go back to the **Source** page.

Before you move on, go ahead and explore the repository. You've already seen the **Source** page, but check out the **Commits**, **Branches**, and **Settings** pages.

---

## RUN
Run Demo_RegSS-SRCNN3D.sh in a bash shell. If a Conda environment is used, please activate it 
before launch the script.