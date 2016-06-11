function dispM = get_disparity(IL,IR,maxDisp,windowSize)

w = (windowSize-1)/2 ;
md = maxDisp ;
dispM=zeros(size(IL,1),size(IL,2)) ;
for i=md+w+1:size(IL,1)-(md+w+1)
    for j=w+1:size(IL,2)-(w+1)
        for d=0:maxDisp
            val(d+1)=norm(double(IL(i-w:i+w,j-w:j+w) - IR(i-w-d:i+w-d,j-w:j+w))) ;
        end
        dispM(i,j)=find(val==min(val),1) ;
    end
end