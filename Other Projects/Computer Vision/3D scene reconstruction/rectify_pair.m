function [M1,M2,K1n,K2n,R1n,R2n,T1n,T2n] = rectify_pair (K1,K2,R1,R2,T1,T2)
c1=-inv(K1*R1)*(K1*T1) ;
c2=-inv(K2*R2)*(K2*T2) ;

r1=(c1-c2)/((sum((c1-c2).*(c1-c2)))^0.5) ;
r2=(cross(R1(3,:),r1))' ;
r3=(cross(r2,r1)) ;
Rn = [r1 r2 r3]' ;
R1n = Rn ;
R2n = Rn ;

T1n = Rn*c1 ;
T2n = Rn*c2 ;

Kn = K2 ;
K1n = Kn ; 
K2n = Kn ;

P1n = [Kn*Rn -Rn*c1] ;
P2n = [Kn*Rn -Rn*c2] ;

M1 = (Kn*Rn)*inv(K1*R1) ;
M2 = (Kn*Rn)*inv(K2*R2) ;