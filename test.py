"""some examples for reading netcdf with python, processing it with fortran
and writing it back to netcdf.
"""


import numpy as np
from netCDF4 import Dataset

# our fortran module compiled with f2py
import mo_test

# define input and output netcdf file
filein  = 'GFILE_allvars_CMIP5_IPSL-CM5A-MR_historical_r1i1p1_19750101.nc'
fileout = 'output.nc' 

# open datasets
datain = Dataset(filein)
dataout = Dataset(fileout, mode='w')

# example of 3d and 2d variable
var3d = 'ta'
var2d = 'ps'

nc3d = datain.variables[var3d]
nc2d = datain.variables[var2d]


# copy dimensions from input netcdf to putput netcdf
for name, dimension in datain.dimensions.items():
    dataout.createDimension(name, (len(dimension) if not dimension.isunlimited() else None))

# create output variables
out3d = dataout.createVariable(var3d, nc3d.datatype, ('lev', 'lat', 'lon'))
out2d = dataout.createVariable(var2d, nc2d.datatype, ('lat', 'lon'))

# get input data from netcdf at timelevel 0.
# we transpose the data so that we can use it in the usual manner in fortran.
timelevel = 0
fnc3d = nc3d[timelevel].T
fnc2d = nc2d[timelevel].T

# call the fortran subroutines and store the results
fnc3d_result = mo_test.mo_test.array3d(fnc3d)
fnc3d_result = mo_test.mo_test.py_sub3d(fnc3d_result)

# transpose the data back to netcdf style and store the output.
out3d[:] = fnc3d_result.T
out2d[:] = fnc2d.T

