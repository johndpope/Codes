function [points] = getRandomPoints(I,alpha)
points(:,1)=round(rand(alpha,1)*(size(I,1)-1)+1);
points(:,2)=round(rand(alpha,1)*(size(I,2)-1)+1);
% imshow(I); hold on ; 
% plot(points(:,2),points(:,1),'r.')
end