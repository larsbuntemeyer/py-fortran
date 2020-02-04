
subroutine sub2d(array, x, y)

      implicit none
      integer, intent(in)   :: x, y
      real*4, intent(inout) :: array(x, y)
!
      write(*,*) 'sub2d, shape: ', shape(array)
      array = sqrt(array)

end subroutine sub2d
