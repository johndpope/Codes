function depthM = get_depth(dispM, K1n, K2n, R1n, R2n, T1n, T2n)

test=1./(dispM) ;
test(test==Inf)= 0 ;

c1 = -(inv(R1n))*T1n ;
c2 = -(inv(R2n))*T2n ;

b = (sum((c1-c2).*(c1-c2)))^0.5 ;
f = K1n(1,1) ;

depthM = f*b*test ;