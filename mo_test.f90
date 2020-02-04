
module mo_test


contains

    function test_func(x,y)
        implicit none
        integer, intent(in) :: x,y
        integer :: test_func
        test_func = x*y
    end function test_func

    subroutine array3d(array, array_out, x, y, z)
        implicit none
        integer, intent(in) :: x, y, z
        real*4, intent(in) :: array(x, y, z)
        real*4, intent(out) :: array_out(x, y, z)
        write(*,*) 'array3d, shape: ', shape(array)
        array_out = array**2
        return
    end subroutine array3d

    subroutine array2d(array, x, y)
        implicit none
        integer, intent(in) :: x, y
        real*4, intent(inout) :: array(x, y)
        write(*,*) 'array2d, shape: ', shape(array)
        array = array**2
    end subroutine array2d

    subroutine py_sub2d(array, x, y)
        implicit none
        integer, intent(in) :: x, y
        real*4, intent(inout) :: array(x, y)
        write(*,*) 'array2d, shape: ', shape(array)
        call sub2d(array, x, y)
    end subroutine py_sub2d

    subroutine py_sub3d(array, array_out, x, y, z)
        implicit none
        integer, intent(in) :: x, y, z
        real*4, intent(in) :: array(x, y, z)
        real*4, intent(out) :: array_out(x, y, z)
        write(*,*) 'array3d, shape: ', shape(array)
        array_out = array
        call sub3d(array_out, x, y, z)
    end subroutine py_sub3d

end module mo_test
