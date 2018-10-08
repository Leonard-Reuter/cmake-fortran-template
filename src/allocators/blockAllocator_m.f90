module blockAllocator_m
    use kinds_m, only : i4, r8

    implicit none
    private

    public :: BlockAllocator_t

    type :: BlockAllocator_t
        integer(i4) :: blockSize = 100
        integer(i4) :: size = 0
        real(r8), allocatable :: vector(:)
    contains
        procedure, pass :: Add => BlockAllocator_Add
        procedure, pass :: Get => BlockAllocator_Get
        procedure, pass :: Create => BlockAllocator_Create
        procedure, pass :: Destroy => BlockAllocator_Destroy
    end type BlockAllocator_t

contains
    pure subroutine BlockAllocator_Create(this,blockSize)
        class(BlockAllocator_t), intent(inout) :: this
        integer(i4), intent(in), optional :: blockSize

        if (present(blockSize)) then
            this%blockSize = blockSize
        end if

        if (allocated(this%vector)) then
            deallocate(this%vector)
        end if

        allocate(this%vector(blockSize))

        this%size = 0
        this%vector = 0._r8
    end subroutine BlockAllocator_Create

    pure subroutine BlockAllocator_Destroy(this)
        class(BlockAllocator_t), intent(inout) :: this

        deallocate(this%vector)
        this%size = 0
        this%blockSize = 100
    end subroutine BlockAllocator_Destroy

    pure function BlockAllocator_Get(this) result(vector)
        class(BlockAllocator_t), intent(in) :: this
        real(r8) :: vector(this%size)

        vector = this%vector(1:this%size)
    end function BlockAllocator_Get

    pure subroutine BlockAllocator_Add(this, r)
        class(BlockAllocator_t), intent(inout) :: this
        real(r8), intent(in) :: r(:)
        real(r8), allocatable :: newVector(:)

        do while ( size(r) + this%size > size(this%vector) )
            ! enlarges this%vector by one blockSize if r does not fit
            allocate( newVector( size(this%vector) + this%blockSize ) )
            newVector = 0._r8
            newVector(1:this%size) = this%vector(1:this%size)
            ! MOVE_ALLOC automatically deallocates newVector
            call MOVE_ALLOC(newVector, this%vector)
        end do

        this%vector(this%size + 1:this%size + size(r)) = r
        this%size = this%size + size(r)
    end subroutine BlockAllocator_Add

end module blockAllocator_m
