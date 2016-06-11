% visualize the data set

% load_mnist_all
% 
% img = xtrain(:, 1);
% img = reshape(img, 28, 28);
% figure,
% imshow(img')
% 
tt = output{1,2}.data ;
k=14 ;
for i=1:5
    subplot(5,4,4*i-3) ;
    imshow(reshape(xtest(:,2*i-1),28,28)')    
    
    tim=reshape(tt(:,2*i-1),24,24,20) ;
    subplot(5,4,4*i-2);
    imshow(tim(:,:,k)') ;
    
    subplot(5,4,4*i-1) ;
    imshow(reshape(xtest(:,2*i),28,28)')    
    
    tim=reshape(tt(:,2*i),24,24,20) ;
    subplot(5,4,4*i);
    imshow(tim(:,:,k)') ;

end
