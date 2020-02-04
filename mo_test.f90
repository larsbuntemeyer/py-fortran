!
! This module is compiled with f2py and linked with external
! subroutines. This module serves as an interface to the call
! of external subroutines which might be legacy code, etc.
! In this module, we can redesign the interface to give back
! an array (with intent(out)). This will be interpreted by
! f2py as a return statement, like in a usual python function.
! The subroutines in this module can then be handled like a pyhon
! function in the python script.
!
! E.g., the subroutine 'array3d' could be called like:
!
!   result = mo_test.mo_test.array3D(my_array)
!
! f2py does not support allocatables, so the array dimensions
! have to be passed explicitly. However, the f2py compiler
! recognizes them as array dimensions and removes them from the
! python interface, so they are not required in the python call.
!
! See test.py for some example calls.
!
! External subroutines which are not compiled with f2py and can
! still have allocatables. However, they have to be linked with
! f2py, e.g., like in the Makefile
!
! written by Lars Buntemeyer
!
module mo_test


contains

    subroutine array3d(array, array_out, x, y, z)
        ! Example for returning a 3d fortran array to python
        implicit none
        integer, intent(in)  :: x, y, z
        real*4,  intent(in)  :: array(x, y, z)
        real*4,  intent(out) :: array_out(x, y, z)
        write(*,*) 'array3d, shape: ', shape(array)
        array_out = array**2
        return
    end subroutine array3d

    subroutine array2d(array, array_out, x, y)
        ! Example for returning a 2d fortran array to python
        implicit none
        integer, intent(in)  :: x, y
        real*4,  intent(in)  :: array(x, y)
        real*4,  intent(out) :: array_out(x, y)
        write(*,*) 'array2d, shape: ', shape(array)
        array_out = array**2
    end subroutine array2d

    subroutine py_sub2d(array, array_out, x, y)
        ! Example for returning a 2d fortran array which is
        ! the result from a call to an external subroutine.
        implicit none
        integer, intent(in)  :: x, y
        real*4,  intent(in)  :: array(x, y)
        real*4,  intent(out) :: array_out(x, y)
        write(*,*) 'py_sub2d, shape: ', shape(array)
        array_out = array
        call sub2d(array_out, x, y)
    end subroutine py_sub2d

    subroutine py_sub3d(array, array_out, x, y, z)
        ! Example for returning a 3d fortran array which is
        ! the result from a call to an external subroutine.
        implicit none
        integer, intent(in)  :: x, y, z
        real*4,  intent(in)  :: array(x, y, z)
        real*4,  intent(out) :: array_out(x, y, z)
        write(*,*) 'py_sub3d, shape: ', shape(array)
        array_out = array
        call sub3d(array_out, x, y, z)
    end subroutine py_sub3d

end module mo_test
