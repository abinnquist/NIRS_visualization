# NIRS_visualization
For visualizing NIRS data or probe specific areas

# Dependencies
Currently I use SPM12 but I belive the older version may work as well. I also use SurfIce to visualize as I find it easy to use and learn but there are other options out there that can be used with the .img file created with the script.
1. SPM - https://github.com/spm/spm12
2. xjview - https://www.alivelearn.net/xjview/download/
3. SurfIce (optional) - https://www.nitrc.org/projects/surfice/

# INPUTS:
- areas - The areas that align with what you are imagin. Could be all
       channels OR channels that add up to an area (i.e., 1-5=mPFC, 6-10=dlPFC,
       etc.). The areas must align with the statistics you are imaging.
- multiDim - 0=2D structure, 1-n=3D structure. Selct which page if 3D
       structure, i.e., data(:,:,multiDim). If left empty will be 0.
- imageValsName - If more than one variable in the .mat file you load in
       (i.e., scan1, scan2, etc.) than you can specify the name of that
       variable. If not, leave empty.
       
# OUTPUT:
Outputs to your current directory (cd) an .img & .hdr of selected values for visualization. Currently I use SurfIce to visualize with the .img

# EXAMPLES
The below examples can be run with the included data in the examples folder and are shown in the linked YouTube companion video.
- Video: https://youtu.be/0sj5Z05t6wU

EXAMPLE 1 (in video): 
       - A 42 channel setup with averaged areas pre-specified in 2D structure, one variable in the .mat file. Can also be used for probe visualization, in which case the .mat should have a row of numbers that specify each area, i.e., 1,2,3,4,5
  - areas={7:14;[1:6,15:20];[25:30,36:41];[21:24,32:35]}; %mPFC, lPFC, TPJ, VM
  - imageNIRSvals(areas)

EXAMPLE 2 (in video): 
  - A 42 channel setup for averaged areas in 3D structure and two seperate variables in the .mat file. Areas are prespecified before running the function.
  - areas={[1:2,5,16,20,26];[3,18,31,36];[4,10,15,19,25,37];[6,11:13,17,22,27,38:39];...
    [7:9,14,28];[21,23,32:34,40];[24,29,35,42];[30,41]}; %VAT_B, FPN_A, FPN_B, DMN_A, DMN_B, DAT_A, DAT_B, TPJ
  - imageNIRSvals(areas, 3, 'Sig_r_neutral')

EXAMPLE 3: 
  - A 42 channel setup all channels in 3D structure with 2nd page selected for visualization, only one variable in the .mat file
  - imageNIRSvals(1:42,2)
