function fak(k) result(fakultaet)
    implicit none
    integer, intent(in) :: k
    integer :: fakultaet
    fakultaet = 1
    integer :: m
    do m=1,k
        fakultaet = fakultaet*m
    end do
end function

program efunktion
    implicit none
    real :: x
    real :: taylorsum
    taylorsum = 0
    integer :: n    ! number of iterations
    n = 10

    print *, 'Enter x: '
    read(*,*) x

    integer :: i    ! iteration variable
    do i=1,n
        taylorsum = taylorsum + (x**i) / fak(i)
    end do

    print *, 'e^x =',taylorsum
end program efunktion
