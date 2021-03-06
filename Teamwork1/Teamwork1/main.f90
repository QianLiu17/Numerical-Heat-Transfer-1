! -------------------------------------------------------
! Computes arithmetic, geometric and harmonic means
! -------------------------------------------------------
PROGRAM ComputeMeans
IMPLICIT NONE
!REAL :: X = 1.0, Y = 2.0, Z = 3.0
!REAL :: ArithMean, GeoMean, HarmMean
!WRITE(*,*) 'Data items: ', X, Y, Z
!WRITE(*,*)
!ArithMean = (X + Y + Z)/3.0
!GeoMean = (X * Y * Z)**(1.0/3.0)
!HarmMean = 3.0/(1.0/X + 1.0/Y + 1.0/Z)
!WRITE(*,*) 'Arithmetic mean = ', ArithMean
!WRITE(*,*) 'Geometric mean = ', GeoMean
!WRITE(*,*) 'Harmonic Mean = ', HarmMean

REAL::Velo
INTEGER::N
WRITE(*,*) 'INPUT THE NUMBER OF CELLS'
READ(*,*)N
WRITE(*,*)'INPUT THE INLET VELOCITY'
READ(*,*)Velo

CALL Center_D(N,Velo)
Pause
END PROGRAM ComputeMeans             
 

SUBROUTINE Center_D(N,Velo)
REAL::Velo
INTEGER::N
REAL::Len=1,Dens=1,Gama=0.1,D,F,Delta_x
REAL,ALLOCATABLE::A_e(:),A_p(:),A_w(:),X(:),Y(:),A(:),B(:),C(:),L(:),U(:),K(:)

ALLOCATE(A_e(N))
ALLOCATE(A_p(N))
ALLOCATE(A_w(N))
ALLOCATE(X(N+1))
ALLOCATE(Y(N))
ALLOCATE(A(N))
ALLOCATE(B(N))
ALLOCATE(C(N))
ALLOCATE(L(N))
ALLOCATE(U(N))
ALLOCATE(K(N))
Delta_x=Len/N
D=Gama/Delta_x
F=Dens*Velo 

DO i=2,N,1
A_e(i)=D-F/2
A_w(i)=D+F/2
A_p(i)=A_e(i)+A_w(i)

A(i)=-A_w(i)
B(i)=A_p(i)
C(i)=-A_e(i)  
L(i)=B(i)
U(i)=C(i)
END DO

X(1)=1
X(N+1)=0
Y(2)=A_w(2)*X(1)
Y(N)=A_e(N)*X(N+1)

DO i=3,N-1,1
Y(i)=0
END DO

DO i=2,N-1,1
K(i)=A(i+1)/L(i)
L(i+1)=L(i+1)-U(i)*K(i)
Y(i+1)=Y(i+1)-Y(i)*K(i)
END DO

X(N)=Y(N)/L(N)

DO i=N-1,2,-1
X(i)=(Y(i)-U(i)*X(i+1))/L(i)
END DO

OPEN(UNIT=1,FILE='Center_D.txt')
DO i=1,N+1,1
WRITE(1,*) X(i)
END DO
RETURN
END SUBROUTINE 