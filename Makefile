TARGS = seawifs-clim-1997-2010.720x576.v20180328.nc
DEPS = ocean_hgrid.nc ocean_mask.nc seawifs-clim-1997-2010.nc

all: $(TARGS) hash.md5
	md5sum -c hash.md5

ocean_hgrid.nc ocean_mask.nc:
	wget -nv ftp://ftp.gfdl.noaa.gov/perm/Alistair.Adcroft/MOM6-testing/OM4_05/$@
	md5sum -c $@.md5

seawifs-clim-1997-2010.720x576.v20180328.nc: seawifs-clim-1997-2010.nc ocean_hgrid.nc ocean_mask.nc
	./interp_and_fill/interp_and_fill.py ocean_hgrid.nc ocean_mask.nc seawifs-clim-1997-2010.nc chlor_a --fms $@

seawifs-clim-1997-2010.nc:
	wget -nv ftp://ftp.gfdl.noaa.gov/perm/Alistair.Adcroft/datasets/seawifs-clim-1997-2010.nc.gz
	gunzip $@.gz
	md5sum -c $@.md5

hash.md5: | $(TARGS)
	md5sum $(TARGS) > $@

clean:
	rm -f $(TARGS) $(DEPS)
