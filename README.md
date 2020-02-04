# py-fortran

a test tool to connect netcdf, python and fortran

# description

The fortran module `mo_test.f90` is compiled with `f2py` and linked with external
subroutines. It serves as an interface to the call of external subroutines 
which might be legacy code, e.g., `sub3d.f90`. The external subroutines can be 
compiled with a normal fortran compiler, hence, they can support full fortran
capabilites while `f2py` does not (e.g., no allocatables).

In the fortran module, we can redesign the interface to give back
an array (with intent(out)). This will be interpreted by
f2py as a return statement, like in a usual python function.
The subroutines in this module can then be handled like a pyhon
function in the python script.

E.g., the subroutine `array3d` in `mo_test.f90` could be called in the
python script like this:

    result = mo_test.mo_test.array3D(my_array)

`f2py` does not support allocatables, so the array dimensions
have to be passed explicitly. However, the `f2py` compiler
recognizes them as array dimensions and removes them from the
python interface, so they are not required in the python call.

See test.py for some example calls.

External subroutines which are not compiled with f2py and can
still have allocatables. However, they have to be linked with
f2py, e.g., like done in the `Makefile`.

Note that the name of the compiled output library from `f2py` should be
`mo_test.so`, however, depending on your system and python version the name
could be different. You might have to rename it to `mo_test.so` which
can then be imported in python. It's also helpful to have a look at the
docstrings, e.g.

    import mo_test
    print(mo_test.mo_test.__doc__)

That's it!

# requirements

* f2py
* fortran compiler

# contact

lars.buntemeyer@hzg.de
