program cylinder
    implicit none

    real :: pi
    real :: radius
    real :: height
    real :: area
    real :: lateral_surface
    real :: volume

    pi = 3.141592

    print *, 'Enter cylinder base radius:'
    read(*,*) radius

    print *, 'Enter cylinder height:'
    read(*,*) height

    area = pi*radius**2.0
    volume = area*height
    lateral_surface = 2.0*pi*radius*height

    print *, 'The cylinder radius is:',radius
    print *, 'The cylinder height is:',height
    print *, 'The cylinder base area is:',area
    print *, 'The cylinder volume is:',volume
    print *, "The cylinder's lateral surface is:",lateral_surface
end program cylinder
