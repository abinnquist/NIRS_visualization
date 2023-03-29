% Image areas based on the statistic of choice. Can be used for
% individual/dyadic or at a group level.

% INPUTS:
% areas - The areas that align with what you are imagin. Could be all
%       channels OR channels that add up to an area (i.e., 1-5=mPFC, 6-10=dlPFC,
%       etc.). The areas must align with the statistics you are imaging.
% multiDim - 0=2D structure, 1-n=3D structure. Selct which page if 3D
%       structure, i.e., data(:,:,multiDim). If left empty will be 0.
% imageValsName - If more than one variable in the .mat file you load in
%       (i.e., scan1, scan2, etc.) than you can specify the name of that
%       variable. If not, leave empty.

% OUTPUT:
% Output to your current directory (cd) an .img & .hdr of selected values 
% for viasualization. Currently I use SurfIce with the .img

% EXAMPLE 1: 
% A 42 channel setup for averaged areas in 3D structure and two seperate
%       variables in the .mat file.
% imageNIRSvals({7:14;[1:6,15:20];[25:30,36:41];[21:24,32:35]}, 3, 'Sig_r_neutral')

% EXAMPLE 2: 
% A 42 channel setup all channels in 3D structure, only one variable in
%       the .mat file
% imageNIRSvals(1:42, 3)

% EXAMPLE 3: 
% A 42 channel setup with averaged areas pre-specified in 2D structure, one 
%       variable in the .mat file. Can also be used for probe
%       visualization, in which case the .mat should have a row of numbers
%       that specify each area, i.e., 1,2,3,4,5
% areas={7:14;[1:6,15:20];[25:30,36:41];[21:24,32:35]}; %mPFC, lPFC, TPJ, VM
% imageNIRSvals(areas)

function fileMade=imageNIRSvals(areas, multiDim, imageValsName)

    if nargin == 2
        imageValsName='';
    elseif nargin == 1
        imageValsName='';
        multiDim=0;
    end

    %Select mni coordinates (will convert from csv to .mat)
    [mniCds, mniPath] = uigetfile('*.csv','Choose the MNI coordinates .csv');
    mniCoords = strcat(mniPath,mniCds);
    mniCoords=readtable(mniCoords);
    mniCoords=table2array(mniCoords);

    % Add SPM12 and xjview to use for imaging
    genPath=uigetdir('','Select the folder path for SPM and xjview');
    addpath(genpath(strcat(genPath,filesep,'xjview')))
    addpath(genpath(strcat(genPath,filesep,'spm12')))
    
    [dataValues, dataPath] = uigetfile('*.mat','Choose the values you want to image');
    data2image = strcat(dataPath,dataValues);

    if ~isempty(imageValsName)
        data2image = struct2array(load(data2image,imageValsName));
    else
        data2image = struct2array(load(data2image));
    end
    
    if multiDim > 0
        %Choose the scan you wish to image    
        scan2img(:,:)=data2image(:,:,multiDim);
        scanName=strcat('Scan_',num2str(multiDim));
    else
        %Choose the scan you wish to image    
        scan2img(:,:)=data2image(:,:);
        scanName=strcat('Scan_',num2str(multiDim));
    end

    statQ = 'What row (i.e., dyad, subject, or statistic) would you like to image (1 to n)? \n';
    stat2img = input(statQ);
    imgName=strcat('NirsStat_',num2str(stat2img),'_',scanName,'.img');

    % Which conversation correlations you want to visualize
    stat_mask=scan2img(stat2img,:)';

    %Repeats the statistic for correct mni coordinate
    scan2mni=nan(length(mniCoords),1);
    for ar=1:length(areas)
        scan2mni(cell2mat(areas(ar,1)),1)=stat_mask(ar);
    end

    % Make sure to change the name of the file
    nirs2img(imgName, mniCoords, scan2mni, 0,0,0)
    
    fileMade='HDR file for imaging saved to current directory';
end
