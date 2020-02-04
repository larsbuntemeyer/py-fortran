
subroutine sub3d(array, x, y, z)

      implicit none
      integer, intent(in) :: x, y, z
      real*4, intent(inout) :: array(x, y, z)
      integer :: ij,i,j,k
      write(*,*) 'sub3d, shape: ', shape(array)
      do k=1,z
        do j=1,y
          do i=1,x
           array(i,j,k) = sqrt(array(i,j,k))
          enddo
        enddo
      enddo

end subroutine sub3d
