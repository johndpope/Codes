 function ess = essentialMatrix(f,K1,K2)

% addpath('../data')
% load('some_Corresp.mat')
% i1 = imread('im1.png') ;
% i2 = imread('im2.png') ;
% f = eightpoint(pts1,pts2,[size(i1,1) size(i1,2) ; size(i2,1) size(i2,2)]) ;
% load('intrinsics.mat')
ess = K1'*f*K2 ;
