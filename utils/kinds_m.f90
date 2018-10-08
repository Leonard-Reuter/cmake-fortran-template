module kinds_m
    use, intrinsic :: iso_fortran_env, only: int8, int16, int32, int64, real32, real64, real128

    implicit none
    private

    public :: i1, i2, i4, i8, r4, r8, r16

    integer(int32), parameter :: i1 = int8
    integer(int32), parameter :: i2 = int16
    integer(int32), parameter :: i4 = int32
    integer(int32), parameter :: i8 = int64
    integer(int32), parameter :: r4 = real32
    integer(int32), parameter :: r8 = real64
    integer(int32), parameter :: r16 = real128

end module kinds_m

