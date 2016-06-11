clear all ;

% --------------------  parameters

% For office dataset

fIL = '../data/office/img_00000_c0_1301078321108104us.pgm' ;
fIR = '../data/office/img_00000_c1_1301078321108123us.pgm' ;
fParam = '../data/camera_office.mat' ;
fgt = '../data/gt_office.mat' ;
fRectP = 'rect_office.mat' ;
fRectIm = 'rect_0_office.png' ;
%}

% For street dataset
%{
fIL = '../data/street/img_00000_c0_1317746099983263us.pgm' ;
fIR = '../data/street/img_00000_c1_1317746099983254us.pgm' ;
fParam = '../data/camera_street.mat' ;
fgt = '../data/gt_street.mat' ;
fRectP = 'rect_street.mat' ;
fRectIm = 'rect_0_street.png' ;
%}
% --------------------  load two images
IL = imread(fIL) ;
IR = imread(fIR) ;

% --------------------  RECTIFICATION

load(fParam, 'K1', 'R1', 'T1', 'K2', 'R2', 'T2') ;

% Part1: Implement this!
[RM1, RM2, K1n, K2n, R1n, R2n, T1n, T2n] = rectify_pair(K1, K2, R1, R2, T1, T2) ;

% save the rectification parameters
save(fRectP, 'RM1', 'RM2', 'K1n', 'K2n', 'R1n', 'R2n', 'T1n', 'T2n');

% --------------------  Display (You don't need to care about this function.)
[rectIL, rectIR, bbL, bbR] = warp_stereo(IL, IR, RM1, RM2) ;

if ~isempty(strfind(fParam,'office')), 
    imwrite(rectIL, 'rectIL_office.pgm') ;
    imwrite(rectIR, 'rectIR_office.pgm') ;
else
    imwrite(rectIL, 'rectIL_street.pgm') ;
    imwrite(rectIR, 'rectIR_street.pgm') ;
end

% -------------------- Display Rectified Images

[nR nC] = size(rectIL) ;
rectImg = zeros(nR, 2*nC, 'uint8') ;
rectImg(:,1:nC) = rectIL ;
rectImg(:,nC+1:end) = rectIR ;

% load gt info.
load(fgt, 'gtL', 'gtR') ; 

% warp left and right points
mlx = p2t(RM1,gtL);
mrx = p2t(RM2,gtR);
mrx(1,:) = mrx(1,:) + nC ;

hfig = figure; imshow(rectImg) ; hold on; 
plot(mlx(1,:)'-bbL(1),mlx(2,:)'-bbL(2), 'r*', 'MarkerSize', 10) ;
plot(mrx(1,:)'-bbR(1),mrx(2,:)'-bbR(2), 'b*', 'MarkerSize', 10) ;
line([ones(size(gtL,2),1) 2*nC*ones(size(gtL,2),1)]', [mlx(2,:)'-bbL(2) mlx(2,:)'-bbL(2)]') ;

% save the rectified image
saveas(hfig, fRectIm) ;
