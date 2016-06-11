function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)

sim=size(Im);

img1=Im ;
img1(img1<threshold)=0 ;

rhoScale = [-800:rhoRes:800];
thetaScale = [-90:thetaRes*180/pi:89] ;
H = zeros(size(rhoScale,2), size(thetaScale,2)) ;

for i=1:sim(1)*sim(2)
    [m,n] = ind2sub(sim,i) ;
       if Im(m,n) > threshold
            for k=-90:thetaRes*180/pi:89
                rho = round(n*cosd(k)+m*sind(k)) ; 
                    H(rhoScale==rho,thetaScale==k) = H(rhoScale==rho,thetaScale==k) + 1;
            end
       end
end


% rhoScale = [0:rhoRes:800];
% thetaScale = [0:thetaRes:2*pi] ;
% H = zeros(size(rhoScale,2), size(thetaScale,2)) ;
% 
% for i=1:sim(1)*sim(2)
%     [m,n] = ind2sub(sim,i) ;
%        if Im(m,n) > threshold
%             for k=0:thetaRes:2*pi
%                 rho = 2*round(((m*cos(k)+n*sin(k))/2)) ; 
%                 if rho > 0
%                     H(rhoScale==rho,thetaScale==k) = H(rhoScale==rho,thetaScale==k) + 1;
%                 end
%             end
%         end
% end

end