program test_solve

  implicit none

  integer :: i, j, ierr, n
  double precision, dimension (:,:), allocatable :: L
  double precision, dimension (:), allocatable :: x, b
  double precision :: backward_error

  write(*,*) 'n?'
  read(*,*) n

  ! Initialization: L is lower triangular
  write(*,*) 'Initialization...'
  write(*,*)
  
  allocate(L(n,n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate L(n,n) with n=',n
    goto 999
  end if

  allocate(x(n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate x(n) with n=',n
    goto 999
  end if

  allocate(b(n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate b(n) with n=',n
    goto 999
  end if

  L = 0.D0
  do i = 1, n  
    L(i,i) = n + 1.D0
    do j = 1, i-1
      L(i,j) = 1.D0
    end do
  end do
  b = 1.D0


  ! Left-looking triangular solve of Lx=b
  write(*,*) 'Solving with a left-looking method...'



  ! TODO : call left_looking_solve
call left_looking_solve(L,x,b,n)
  
  ! TODO : call backward_error to check the accuracy
print *, "left backward_error : ",backward_error(L,x,b,n)

  ! TODO : display the solution if n <= 10
 if (n <= 10) print *, 'la solution est : ',x


  ! Right-looking triangular solve of Lx=b
  write(*,*) 'Solving with a right-looking method...'

  ! TODO : call right_looking_solve
call right_looking_solve(L,x,b,n)

  ! TODO : call backward_error to check the accuracy
print *, "right backward_error : ",backward_error(L,x,b,n)

  ! TODO : display the solution if n <= 10
 if (n <= 10) print *, 'la solution est : ',x


999 if(allocated(L)) deallocate(L)
    if(allocated(x)) deallocate(x)
    if(allocated(b)) deallocate(b)

end program test_solve

! TODO
! Implement sub-programs left_looking_solve, right_looking_solve, backward_error

! procédure left_looking_solve
! effectue la résolution sans report du système triangulaire Lx = b
! x : le vecteur (résultat)
! L : matrice de taille n×n de nombres réels double précision (donnée)
! b : second membre, vecteur de taille n de nombres réels double précision (donnée)
! n : la dimension des vecteurs/matrice (donnée)
! pré-condition : L est initialisée et aucun terme de sa diagonale n’est nul et n > 0
! post-condition : x contient la solution de Lx = b
subroutine left_looking_solve(L,x,b,n)
 implicit none
 integer, intent(in) :: n
 double precision, intent(in), dimension(n,n) :: L
 double precision, intent(in), dimension(n) :: b
 double precision, intent(out), dimension(n) :: x
 integer :: i,j
 real :: start,finish
call cpu_time(start)
x = b
b1 : do j = 1, n
    b2 : do i = 1, j-1
        x(j) = x(j) - L(j,i)*x(i)
    end do b2
    x(j) = x(j)/L(j,j)
end do b1
call cpu_time(finish)
print *, 'Time left (s) : ',finish-start
 return
end subroutine left_looking_solve


! procédure right_looking_solve
! effectue la résolution avec report du système triangulaire Lx = b
! x : le vecteur (résultat)
! L : matrice de taille n×n de nombres réels double précision (donnée)
! b : second membre, vecteur de taille n de nombres réels double précision (donnée)
! n : la dimension des vecteurs/matrice (donnée)
! pré-condition : L est initialisée et aucun terme de sa diagonale n’est nul et n > 0
! post-condition : x contient la solution de Lx = b
subroutine right_looking_solve(L,x,b,n)
 implicit none
 integer, intent(in) :: n
 double precision, intent(in), dimension(n,n) :: L
 double precision, intent(in), dimension(n) :: b
 double precision, intent(out), dimension(n) :: x
 integer :: i,j
 real :: start,finish
call cpu_time(start)
x = b
b1 : do j = 1, n
    x(j) = x(j)/L(j,j)
    b2 : do i = j + 1, n
        x(i) = x(i) - L(i,j)*x(j)
    end do b2
end do b1
call cpu_time(finish)
print *, 'Time right (s) : ',finish-start
 return
end subroutine right_looking_solve



! fonction backward_error
! calcule l'erreur inverse norm2(Lx-b)/norm2(b)
! x : olution calculée, vecteur de taille n de nombres réels double précision (donnée)
! L : matrice de taille n×n de nombres réels double précision (donnée)
! b : second membre, vecteur de taille n de nombres réels double précision (donnée)
! n : la dimension des vecteurs/matrice (donnée)
! pré-condition : n > 0
double precision function backward_error(L,x,b,n)
 implicit none
 integer, intent(in) :: n
 double precision, intent(in), dimension(n,n) :: L
 double precision, intent(in), dimension(n) :: b
 double precision, intent(in), dimension(n) :: x

 ! initialisation
 ! backward_error = 0.0

 ! calcul de l'erreur
 backward_error = NORM2(matmul(L,x) - b)/NORM2(b)
 ! backward_error contient norm2(Lx-b)/norm2(b)

 return
end function backward_error




! Différences de performance entre les 2 algorithmes :
! Pour des valeurs de n assez grandes, l'algorithme de droite (right_looking_solve) s'exécute plus vite que l'autre (le temps passé dans la procédure devient significativement plus faible => pour n = 20000, 0.16s < 1.88s) pour des erreurs inverses égales. L'algorithme de résolution avec report semble donc plus performant que celui sans report.
Cela s'explique par le fait que pour l'algorithme de gauche, chaque itération de j permet uniquement de calculer x(j) (à partir des x(i) pour i<j) alors que dans l'autre algorithme chaque itération de j permet aussi de calculer les x(i) (avec i>j). Dans un cas on calcule chaque coefficient d'affilée, dans l'autre on les construit au fure et à mesure, ce qui est moins long lorsque l'on travaille avec des matrices de grandes dimensions (n très grand).



