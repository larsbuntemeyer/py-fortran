

f90 = gfortran

fobjs = sub2d.o sub3d.o
f2pyo = mo_test.o


f2py: $(fobjs) $(f2pyo)
	f2py3 -c --fcompiler=gfortran $(fobjs) mo_test.f90 -m mo_test

clean:
	rm *.so *.o *.mod

%.o : %.f90
	$(f90) -c -fPIC $<
