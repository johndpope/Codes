clear all ;

% --------------------  parameters

% For office dataset

fIL = 'rectIL_office.pgm' ;
fIR = 'rectIR_office.pgm' ;
fRectP = 'rect_office.mat' ;
fDispIm = 'disparity_0_office.png' ;
fDepthIm = 'depth_0_office.png' ;
%}

% For street dataset
%{
fIL = 'rectIL_street.pgm' ;
fIR = 'rectIR_street.pgm' ;
fRectP = 'rect_street.mat' ;
fDispIm = 'disparity_0_street.png' ;
fDepthIm = 'depth_0_street.png' ;
%}
% --------------------  load two images
IL = imread(fIL) ;
IR = imread(fIR) ;


% --------------------  load RECTIFICATION

% load the rectification parameters
load(fRectP, 'RM1', 'RM2', 'K1n', 'K2n', 'R1n', 'R2n', 'T1n', 'T2n');


% --------------------  get disparity map

maxDisp = 15; 
windowSize = 5 ;
dispM = get_disparity(IL, IR, maxDisp, windowSize) ;



% --------------------  get depth map

depthM = get_depth(dispM, K1n, K2n, R1n, R2n, T1n, T2n) ;


% --------------------  Display

figure; imagesc(dispM); colormap(gray); axis image;
figure; imagesc(depthM); colormap(gray); axis image;


% -------------------- File saving

% imwrite(dispM, fDispIm) ;
% imwrite(depthM, fDepthIm) ;
save('dispM_St.mat','dispM')
save('depthM_St.mat','depthM')