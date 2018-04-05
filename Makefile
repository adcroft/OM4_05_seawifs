TARGS = seawifs-clim-1997-2010.720x576.v20180328.nc
DEPS = ocean_hgrid.nc ocean_mask.nc seawifs-clim-1997-2010.nc

all: $(TARGS) hash.md5
	md5sum -c hash.md5

ocean_hgrid.nc ocean_mask.nc:
	wget ftp://ftp.gfdl.noaa.gov/home/aja/OM4_05_grid.unpacked/$@
	md5sum -c $@.md5

seawifs-clim-1997-2010.720x576.v20180328.nc: seawifs-clim-1997-2010.nc ocean_hgrid.nc ocean_mask.nc
	./interp_and_fill/interp_and_fill.py ocean_hgrid.nc ocean_mask.nc seawifs-clim-1997-2010.nc chlor_a --fms $@

hash.md5: | $(TARGS)
	md5sum $(TARGS) > $@

clean:
	rm -f $(TARGS) $(DEPS)
