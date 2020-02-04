"""some examples for reading netcdf with python, processing it with fortran
and writing it back to netcdf.
"""


import numpy as np
from netCDF4 import Dataset

# our fortran module compiled with f2py
import mo_test

# define input and output netcdf file (data is available at DKRZ)
tas_file = '/pool/data/CMIP5/cmip5/output1/MPI-M/MPI-ESM-LR/historical/mon/atmos/Amon/r1i1p1/v20120315/tas/tas_Amon_MPI-ESM-LR_historical_r1i1p1_185001-200512.nc'
ta_file  = '/pool/data/CMIP5/cmip5/output1/MPI-M/MPI-ESM-LR/historical/mon/atmos/Amon/r1i1p1/v20120315/ta/ta_Amon_MPI-ESM-LR_historical_r1i1p1_185001-185912.nc'
out_file = 'output.nc'

# open datasets
ta_dataset  = Dataset(ta_file)
tas_dataset = Dataset(tas_file)
dataout     = Dataset(out_file, mode='w')

# example of 3d and 2d variable
var3d = 'ta'
var2d = 'tas'

nc3d = ta_dataset.variables[var3d]
nc2d = tas_dataset.variables[var2d]


# copy dimensions from input netcdf to putput netcdf
for name, dimension in ta_dataset.dimensions.items():
    dataout.createDimension(name, (len(dimension) if not dimension.isunlimited() else None))

# create output variables
out3d = dataout.createVariable(var3d, nc3d.datatype, ('plev', 'lat', 'lon'))
out2d = dataout.createVariable(var2d, nc2d.datatype, ('lat', 'lon'))

# get input data from netcdf at timelevel 0.
# we transpose the data so that we can use it in the usual manner in fortran.
timelevel = 0
fnc3d = nc3d[timelevel].T
fnc2d = nc2d[timelevel].T

# -- CALL TO FORTRAN ROUTINES --
# call the fortran subroutines and store the results
# you could do some complex stuff here.
fnc3d_result = mo_test.mo_test.array3d(fnc3d)
fnc3d_result = mo_test.mo_test.py_sub3d(fnc3d_result)
# -- CALL TO FORTRAN ROUTINES --

# transpose the data back to netcdf style and store the output.
out3d[:] = fnc3d_result.T
out2d[:] = fnc2d.T

dataout.close()
