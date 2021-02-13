function fak(k) result(fakultaet)
    implicit none
    integer, intent(in) :: k
    integer :: fakultaet
    integer :: m
    fakultaet = 1
    do m=1,k
        fakultaet = fakultaet*m
    end do
end function

program efunktion
    implicit none
    real :: x
    real :: taylorsum
    integer :: n    ! number of iterations
    integer :: i    ! iteration variable
    taylorsum = 0
    n = 10

    print *, 'Enter x: '
    read(*,*) x

    do i=1,n
        taylorsum = taylorsum + (x**i) / fak(i)
    end do

    print *, 'e^x =',taylorsum
end program efunktion
