
!subroutine sub2d(array)
subroutine sub2d(array)

      implicit none
      real*4, intent(inout) :: array(144*143)
!
      write(*,*) 'sub2d, shape: ', shape(array)
      array = sqrt(array)

end subroutine sub2d
