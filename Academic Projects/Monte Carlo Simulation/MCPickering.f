!      In this code,  A mixture of oppositely charged colloids are placed on a sphere and Monte Carlo Simulation is performed
!      Verlet list included
!
!-------------------------------------------------------------------------

       Program Stability
       
       Implicit None
       
       Include 'par.h'
       Include 'conf.inc'

       Integer i, ii, ncycle, icycle, imove
       Integer attempt, Nacc, nind, number_neighbour
       Double Precision rseed, dr, dist_com, En, insE(5), sumE, ratiom
       Integer sattempt, sNacc
	Double Precision randf
!! number_neighbour     : total number of neighbours of all the particle
!! dist_com             : average distance of all the particles from center-of-mass
       
       rseed = - 5804584100d0  !(always initiate the random no with negative signed seed)  
       dr    = 0.03d0
       Open(10,file='emulsion_con.dat') !read configuration from file 
       Do i=1, N
          Read(10,*) rx(i), ry(i), rz(i), charge(i)
       Enddo
       Close(10)
       Call configwrite(0,-1)
       Open(13, file='acc_move.dat')

       Call newVlist() ! to setup neighbour list

       Call totalenergy(En, number_neighbour)

!       Call averagedistance(dist_com)

       Open(11, file='energy.dat')

       Write(11, 1111) 0, En/dble(N),  
     &                 dble(number_neighbour)/dble(2*N),dist_com
       
       Do ii=1, 2
          If (ii .eq. 1) then
              ncycle = eqcycle
          Else 
              ncycle = procycle
          Endif
          attempt = 0
          Nacc = 0
          nind = 1
	  sattempt = 0
	  sNacc = 0
          Do icycle = 1, ncycle
             Do imove = 1, N
	      If (randf(rseed) .lt. (1.0-ps)) then
                Call MCmove(En,attempt,Nacc,dr,rseed,number_neighbour)
              Else
              Call MCswap(En,sattempt,sNacc,dr,rseed,number_neighbour)
              Endif
             Enddo
             If (ii .eq. 1) then
                 If (mod (icycle, nxyz) .eq. 0) then
                     Call configwrite(1,icycle)
                 Endif
                 If (icycle .gt. (nind*nsample - 5) ) then ! write instantaneous energy (averaged over 5 conf)
                        i = mod(icycle, 5)
                        insE(i+1) = En
                 Endif
                 If ( mod(icycle, nsample) .eq. 0 ) then
!                      Call averagedistance(dist_com)
                      sumE = 0.0d0
                      Do i=1, 5
                         sumE = sumE + insE(i)
                      Enddo
                         sumE = sumE / 5.0
!                      Write(11, 1111) dble(icycle), sumE/dble(N), 
!     &                  dble(number_neighbour)/dble(2*N), dist_com,
!     &	                dble(sNacc/sattempt)	 
                       Write(11, 1111) dble(icycle), sumE/dble(N), 
     &                  dble(number_neighbour)/dble(2*N),
     &	                dble(sNacc)/dble(sattempt)	

                     nind = nind + 1
                      print*, "eq", icycle
                 Endif
                 If ( mod(icycle, nadj) .eq. 0) then
                      If (attempt .ne. 0) then
                         ratiom = real(Nacc)/real(attempt)
                         Write(13, 1313) dble(icycle), ratiom, dr
                         If (ratiom .lt. 0.4d0) then
                            dr = dr / 1.05d0
                         Elseif(ratiom .gt. 0.6d0) then
                            dr = dr * 1.05d0
                         Endif
                         If (dr .gt. box/2.) dr = box/2.
                         If (dr .lt. 1.0d-5) dr = 1.0d-5
                         attempt = 0
                         Nacc = 0
                      Endif
                 Endif
             Endif

             If (ii .eq. 2) then
                If ( icycle .gt. (nind*nsample - 5) ) Then
                        i = mod(icycle, 5)
                        insE(i+1) = En
                Endif
                If ( mod (icycle, nsample ) .eq. 0) then
!                    Call averagedistance(dist_com)
                     sumE = 0.0
                     Do i=1, 5
                        sumE = insE(i) + sumE
                     Enddo
                     sumE = sumE / 5.0
!                     Write(11, 1111) dble(icycle+eqcycle), sumE/dble(N),
!    $                    dble(number_neighbour)/dble(2*N), dist_com
                    Write(11, 1111) dble(icycle+eqcycle), sumE/dble(N),
     $                    dble(number_neighbour)/dble(2*N)

			 nind = nind + 1
                      print*, "prod", icycle
                Endif
                If(mod (icycle, nxyz) .eq. 0) Then
                   Call configwrite(1,icycle)
		   print*, 'check'
                Endif

             Endif

          Enddo  ! end of (equilibration or production)
       Enddo  ! end of ii-loop (equilibrium and production)

      Open(12,file='config_final.txt')
      Do i=1, N
          Write(12,*) rx(i), ry(i), rz(i), charge(i)
      Enddo
      write(26,*) 'running energy=', En/dble(N)
      Call totalenergy(En, number_neighbour)
      write(26,*) 'final total energy=', En/dble(N)
      write(26,*)

      Call configwrite(2,icycle)
1111  Format(2X, 5(F20.7, 2X))
1313  Format(2X, 3(F20.7, 2X))

      Stop
      End
!-----------------------------Subroutine to write configuration-----------
	Subroutine configwrite(x,cyle)
       Implicit None
       Include 'par.h'
       Include 'conf.inc'
       Integer i, j, x, fileind, cyle, k, cycle_no
       Double precision box2, n_positive, n_negative, Dist_1, Dist_2
       Double precision Dist

       box2 = 0.5d0*box
       If (x .eq. 0 ) Then
           fileind = 30
           Open(fileind,file='initial.xyz')
       Elseif(x .eq. 1) Then
           fileind = 21
           Open(fileind,file='running.xyz')
	   Open(50,file='neighbour_list_running.xyz')
	   Open(60,file='MSD.xyz')
	   Open(70,file='RDF.xyz')
       Elseif (x .eq. 2) Then
           fileind = 22
           Open(fileind,file='final.xyz')
       Endif
       
         
       Write(fileind, *) N+8
       Write(fileind, *)
       Write(fileind, 1212) 'Li', -box2, -box2, -box2
       Write(fileind, 1212) 'Li',  box2, -box2, -box2
       Write(fileind, 1212) 'Li', -box2,  box2, -box2
       Write(fileind, 1212) 'Li', -box2, -box2,  box2
       Write(fileind, 1212) 'Li',  box2,  box2, -box2
       Write(fileind, 1212) 'Li',  box2, -box2,  box2
       Write(fileind, 1212) 'Li', -box2,  box2,  box2
       Write(fileind, 1212) 'Li',  box2,  box2,  box2
	
	
	n_positive = 0
	n_negative = 0
	cycle_no = cyle/nsample
       Do i = 1, N
        If (charge(i) .EQ. 1) Then
          Write(fileind, 1212) 'H', rx(i), ry(i), rz(i)
        !  print*, 'H', charge(i)
        Else
           Write(fileind, 1212) 'He', rx(i), ry(i), rz(i)
         !   print*, 'He', charge(i)
        Endif
	Enddo
	

		If ( x .EQ. 1 ) Then
		Do i = 1, N
			no_neig(i) = 0
			If (charge(i) .EQ. 1) Then
			n_positive = n_positive + 1
			Endif
		Enddo
		Endif

	
	If ( x .EQ. 1 ) Then
		Do i = 1, N
			k = 0
			If(charge(i) .EQ. 1) Then
				Do j = 1, N
					If( charge(j) .EQ. -1) Then
	Dist_1 = (rx(i)-rx(j))*(rx(i)-rx(j)) + (ry(i)-ry(j))*(ry(i)-ry(j))
				Dist_2 = Dist_1 + (rz(i)-rz(j))*(rz(i)-rz(j))
				Dist = sqrt(Dist_2) 
					
					print*, int(Dist)
					no_tot(int(Dist))= no_tot(int(Dist)) + 1
					Endif
				Enddo
			Endif
		Enddo
	Endif
	
	
	
	If (x .EQ. 2) Then
	Do i = 1, 100
              print*, no_tot(i)/1092/20       
	Enddo
	Endif


1212   Format(2X, 1A, 3(F14.7, 2X))
1234   Format(3(I4),4(F14.7, 4X))
1223   Format(I4,(F14.7, 4x))
1115   Format(F14.7, 4x)
1555   Format(I4,(F14.7, 4X))
       Return
       End

!------------------
!	MC swap move
!
	Subroutine MCswap(En, sattempt, sNacc,dr,rseed, number_neighbour)

        Implicit none

	Include 'par.h'
	Include 'conf.inc'

        Double precision rxio, ryio, rzio, rxjo, ryjo, rzjo
	Double precision Enold, Ennew, En, delE, delEB, rseed,dr
	Integer Ni, Nj, number_neighbour, sNacc, sattempt
	Double precision arg, randf
	Integer neigh_old, neigh_new
	
	sattempt = sattempt + 1
        Call totalenergy(En, neigh_old) 
        Enold = En
	Ni = 1+ int (N*randf(rseed))
        Nj = 1+ int (N*randf(rseed))
        
        rxio = rx(Ni)
	ryio = ry(Ni)
	rzio = rz(Ni)
	rxjo = rx(Nj)
	ryjo = ry(Nj)
	rzjo = rz(Nj)
       
        rx(Ni) = rx(Nj)
	ry(Ni) = ry(Nj)
	rz(Ni) = rz(Nj)

	rx(Nj) = rxio
	ry(Nj) = ryio
	rz(Nj) = rzio

        Call totalenergy(Ennew, neigh_new)
         delE  = Ennew - Enold
         delEB = delE / T
!         If ( delEB .lt. 100.0d0) Then
              arg = exp(-delEB)
            If (randf(rseed) .lt. arg) Then
                sNacc = sNacc + 1
                En   = Ennew
                number_neighbour = number_neighbour +
     &                             neigh_new - neigh_old
                Call newVlist
!           Endif
	  Else
	    rx(Ni) = rxio
	    ry(Ni) = ryio
	    rz(Ni) = rzio
	    rx(Nj) = rxjo 
            ry(Nj) = ryjo 
            rz(Nj) = rzjo
	    En = Enold
	    
       Endif
         Return
	End

!------------------
!-----------------------------------------------------------------------
!     Constrained Monte Carlo simulation
!     Headgroups are held fixed; only counterions are moved
!-----------------------------------------------------------------------
       Subroutine MCmove(En,attempt,Nacc,dr,rseed,number_neighbour)

       Implicit None

       Include 'par.h'
       Include 'conf.inc'
       
       Integer attempt, Nacc, newN, neigh_old, neigh_new
       Integer number_neighbour
       Double precision rseed, randf, rold
       Double precision  rxio, ryio, rzio, rxij, ryij, rzij, rij, arg
       Double precision Eold, Enew, En, dr, rxn, ryn, rzn, delE, delEB
       
       attempt = attempt + 1 
       newN = 1 + int( N*randf(rseed) )  
       If(newN .gt. N) newN = N
       rxio = rx(newN)
       ryio = ry(newN)
       rzio = rz(newN)
 
       rxij = rxio - rxo(newN)
       ryij = ryio - ryo(newN)
       rzij = rzio - rzo(newN)
       rij = sqrt(rxij*rxij + ryij*ryij + rzij*rzij)

       If(rij .gt. (rlist-rcut)/2.) Call newVlist
       
       Call energy( newN, rxio, ryio, rzio, Eold, neigh_old )
       rxn = rxio + ( 1.0d0 - 2.0d0*randf(rseed) ) * dr
       ryn = ryio + ( 1.0d0 - 2.0d0*randf(rseed) ) * dr
       rzn = rzio + ( 1.0d0 - 2.0d0*randf(rseed) ) * dr
! dont apply minimum image conversion for emulsion droplet
!       rxn = rxn - box* anint( rxn / box )
!       ryn = ryn - box* anint( ryn / box )
!       rzn = rzn - box* anint( rzn / box )
       rold = sqrt(rxn*rxn+ryn*ryn+rzn*rzn)
       rxn = rxn*Eradius/rold
       ryn = ryn*Eradius/rold
       rzn = rzn*Eradius/rold
       rxij = rxn - rxo(newN)
       ryij = ryn - ryo(newN)
       rzij = rzn - rzo(newN)
       rij = sqrt(rxij*rxij + ryij*ryij + rzij*rzij)

       If( rij .gt. (rlist-rcut)/2. ) Call newVlist

       Call energy( newN, rxn, ryn, rzn, Enew, neigh_new )
       delE  = Enew - Eold
       delEB = delE / T
       If ( delEB .lt. 100.0d0) Then
            arg = exp(-delEB)
            If (randf(rseed) .lt. arg) Then
                Nacc = Nacc + 1
                En   = En + delE
                number_neighbour = number_neighbour + 
     &                             neigh_new - neigh_old
                rx(newN) = rxn
                ry(newN) = ryn
                rz(newN) = rzn             
                Nacc = Nacc + 1
            Endif
       Endif
       
       Return
       End

!-----------------------------------------------------------------------
!     Calculation of Energy
!-----------------------------------------------------------------------
      Subroutine totalenergy (En, number_neighbour)
      
      Implicit None
      
      Include 'par.h'
      Include 'conf.inc'

      integer i, j, number_neighbour 
      Double Precision rxi, ryi, rzi, rxij, ryij, rzij, rij2, rij, V, En

      En = 0.0d0
      V = 0.0d0
      number_neighbour = 0
      Do i = 1, N-1
         rxi = rx(i)
         ryi = ry(i)
         rzi = rz(i)
         Do j = i+1, N
            rxij  = rxi - rx(j)
            ryij  = ryi - ry(j)
            rzij  = rzi - rz(j)
!dont apply minimum image conversion for emulsion droplet
!            rxij  = rxij - box * anint (rxij/box)
!            ryij  = ryij - box * anint (ryij/box)
!            rzij  = rzij - box * anint (rzij/box)
            rij2  = rxij * rxij  + ryij * ryij + rzij * rzij
            rij   = sqrt(rij2)
            V = 0.0d0
            If ( rij .lt. rcut ) Then
              If( (charge(i) .EQ. 1) .AND. (charge(j) .EQ. 1) ) Then
                If ( rij .lt. sig1 ) Then
                     V = 1.0d50
                     En = V
                     print*, i, j, rij
                     Print*, 'Totalenergy', En
                     Return
                Else
                    V = Q1*Q1/(rij2*rij)
                    number_neighbour = number_neighbour + 1
                    En = En + V
                Endif 

              Elseif ( (charge(i) .EQ. -1) .AND. 
     &                 (charge(j) .EQ. -1)) Then
                If ( rij .lt. sig2 ) Then
                     V = 1.0d50
                     En = V
                     print*, i, j, rij
                     Print*, 'Totalenergy', En
                     Return
                Else
                    V = Q2*Q2/(rij2*rij)
                    number_neighbour = number_neighbour + 1
                    En = En + V
                Endif

              Else 
                If ( rij .lt. 0.5*(sig1+sig2) ) Then
                     V = 1.0d50
                     En = V
                     print*, i, j, rij
                     Print*, 'Totalenergy', En
                     Return
                Else
                    V = Q1*Q2/(rij2*rij)
                    number_neighbour = number_neighbour + 1
                    En = En + V
                Endif 
              Endif

            Endif
         Enddo
      Enddo   
      
      En = En * prefactor  ! prefactor = 2/(4*pi*eps_0*eps_w*kappa^2)

      Return

      End       
!----------------------------------------------------------------
!       Energy calculation 
!----------------------------------------------------------------
      Subroutine energy (newN, rxi, ryi, rzi, Eni, neigh_no)

      Implicit none

      Include 'par.h'
      Include 'conf.inc'

      Integer i, j, newN, neigh_no
      Double Precision rxi, ryi, rzi, rxij, ryij, rzij, rij2, rij
      Double precision V, Eni
        
      Eni = 0.0d0
      neigh_no = 0
      V = 0.0d0
      Do i = 1, nlist(newN)
         j = list(newN, i)
         If ( newN .ne. j ) Then
            rxij  = rxi - rx(j)
            ryij  = ryi - ry(j)
            rzij  = rzi - rz(j)   
!dont apply minimum image conversion for emulsion droplet
   
!            rxij  = rxij - box * anint (rxij/box)
!            ryij  = ryij - box * anint (ryij/box)
!            rzij  = rzij - box * anint (rzij/box)
            rij2  = rxij * rxij  + ryij * ryij + rzij * rzij
            rij   = sqrt(rij2)
   
            V = 0.0d0
            If ( rij .lt. rcut ) Then
                If( (charge(newN) .EQ. 1) .AND. 
     &              (charge(j) .EQ. 1) ) Then
                  If ( rij .lt. sig1 ) Then
                     Eni = 1.0d50
                     Return
                  Else
                     V = Q1*Q1/(rij2*rij)
                     neigh_no = neigh_no + 1
                     Eni = Eni + V
                  Endif 
 
                Elseif ( (charge(newN) .EQ. -1) .AND. 
     &                    (charge(j) .EQ. -1)) Then
                  If ( rij .lt. sig2 ) Then
                     Eni = 1.0d50
                     Return
                  Else
                     V = Q2*Q2/(rij2*rij)
                     neigh_no = neigh_no + 1
                     Eni = Eni + V
                  Endif

                Else 
                  If ( rij .lt. 0.5*(sig1+sig2) ) Then
                     Eni = 1.0d50
                     Return
                  Else
                     V = Q1*Q2/(rij2*rij)
                     neigh_no = neigh_no + 1
                     Eni = Eni + V
                  Endif 
                Endif 
            Endif
         Endif
      Enddo
      Eni = Eni * prefactor  ! prefactor = 2/(4*pi*eps_0*eps_w*kappa^2)
      Return
      End

!-------------------------------------------------------------
!       Subroutine to update the Verlet-neighbour list
!-------------------------------------------------------------
        Subroutine newVlist()

        Implicit none

        Include 'par.h'
        Include 'conf.inc'

        Integer i, j
	Double Precision rxi, ryi, rzi, rxij, ryij, rzij, rij2, rlist2

        rlist2 = rlist*rlist
        Do i = 1, N
           nlist(i) = 0
           rxo(i) = rx(i)
           ryo(i) = ry(i)
           rzo(i) = rz(i)
           Do j=1, N
              list(i,j) = 0
           Enddo
        Enddo

        Do i = 1, N-1
  	   rxi = rx(i)
	   ryi = ry(i)
	   rzi = rz(i)
	   Do j = i+1, N
	      rxij = rxi - rx(j)
	      ryij = ryi - ry(j)
	      rzij = rzi - rz(j)
!do not apply minimum image conversion for emulsion droplet
!	      rxij = rxij - box * anint(rxij/box)
!	      ryij = ryij - box * anint(ryij/box)
!	      rzij = rzij - box * anint(rzij/box)

	      rij2 = rxij*rxij + ryij*ryij + rzij*rzij

 	      If (rij2 .lt. rlist2) Then
	         nlist(i) = nlist(i) + 1
	         nlist(j) = nlist(j) + 1
	         If(nlist(i) .gt. N .or. 
     >              nlist(j) .gt. N ) Then
	            Print*, 'list is too small'
	            Stop
                 Else
	            list( i, nlist(i) ) = j
	            list( j, nlist(j) ) = i
	         Endif
              Endif
	   Enddo
	Enddo

	Return
	End

!----------------------------------------------------------
!     Uniformly Distributed Random Number Generator
!----------------------------------------------------------
       Double Precision Function randf(rseed)
       Implicit None
         
       Integer IM1, IM2, IA1, IA2, IQ1, IQ2, IR1, IR2, NTAB, IV
       Integer IMM1, Ndiv, IY, IDUM, IDUM2, j, k    
       Double Precision EPS, RNMX, AM, rseed
       
*        PARAMETER (IM1=2147483563,IM2=2147483399,AM=1.0D00/IM1,
*     &  IMM1=IM1-1,IA1=40014,IA2=40692,IQ1=53668,IQ2=52774,IR1=12211,
*     &  IR2=3791,NTAB=32,NDIV=1+IMM1/NTAB)
       Parameter (IM1=2147483563,IM2=2147483399,
     &            IA1=40014,IA2=40692,IQ1=53668,IQ2=52774,IR1=12211,
     &            IR2=3791,NTAB=32)
        Parameter (EPS=1.2D-14,RNMX=1.0D00-EPS)
C RAN2 OF NUMERICAL RECIPES 2ND ED.
        Dimension IV(NTAB)
        Save IV,IY,IDUM2
        Data IDUM2/123456789/,IV/NTAB*0/,IY/0/

        IDUM=int(rseed)
        AM=1.d0/im1
        IMM1=IM1-1
        Ndiv=1+IMM1/NTAB
        
        IF (IDUM.LE.0) THEN
            IDUM=MAX(-IDUM,1)
            IDUM2=IDUM
            DO j = NTAB+8,1,-1
               K=IDUM/IQ1
               IDUM=IA1*(IDUM-K*IQ1)-K*IR1
               IF(IDUM.LT.0)IDUM=IDUM+IM1
               IF(J.LE.NTAB)IV(J)=IDUM
            ENDDO
            IY=IV(1)
        ENDIF
        
        K=IDUM/IQ1
        IDUM=IA1*(IDUM-K*IQ1)-K*IR1
        IF(IDUM.LT.0)IDUM=IDUM+IM1
        K=IDUM2/IQ2
        IDUM2=IA2*(IDUM2-K*IQ2)-K*IR2
        IF(IDUM2.LT.0)IDUM2=IDUM2+IM2
        J=1+IY/NDIV
        IY=IV(J)-IDUM2
        IV(J)=IDUM
        IF(IY.LT.1)IY=IY+IMM1
        
        randf=MIN(AM*IY,RNMX)

        rseed=float(IDUM)

        RETURN
        END
!--------------------------------------------------
