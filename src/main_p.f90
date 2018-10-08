program main_p
    use kinds_m, only : i4, r8
    use blockAllocator_m, only: BlockAllocator_t

    implicit none

    type(BlockAllocator_t) :: blockAllocator
    integer(i4) :: i
    real(r8) :: ref(7) = [ (i * 1._r8, i = 1,7)]
    real(r8), allocatable :: ref2(:)

    call blockAllocator%create(10)

    call blockAllocator%add(ref)
    call blockAllocator%add(ref)

    ! next line uses automatic allocation on assign (Fortran 2008)
    ref2 = blockAllocator%get()

    deallocate(ref2)

    write(*,'(a)') "Hello World!"
    call blockAllocator%destroy()

end program main_p
