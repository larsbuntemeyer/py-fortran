
subroutine sub3d(array)

      implicit none
      real*4, intent(inout) :: array(144*143,39)
      integer :: ij,i,j,k
      write(*,*) 'sub3d, shape: ', shape(array)
!      array = sqrt(array)
      do k=1,39
        do ij=1,144*143
           array(ij,k) = sqrt(array(ij,k))
        enddo
      enddo 

end subroutine sub3d
