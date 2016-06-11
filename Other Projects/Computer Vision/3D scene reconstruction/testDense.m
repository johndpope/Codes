    
a=load('depthM_Office.mat') ;
dep_st1=a.depthM ;
m1 = size(dep_st1) ;

a=repmat([1:m1(1)]',1,m1(2));
b=repmat([1:m1(2)],m1(1),1);
a=a(:);
b=b(:);

plot3(a,b,dep_st1(:),'.')

pause

a=load('depthM_St.mat') ;
dep_st1=a.depthM ;
m1 = size(dep_st1) ;

a=repmat([1:m1(1)]',1,m1(2));
b=repmat([1:m1(2)],m1(1),1);
a=a(:);
b=b(:);

plot3(a,b,dep_st1(:),'.')