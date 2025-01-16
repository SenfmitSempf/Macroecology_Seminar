library(geodata)
library(terra)

# load UK map/British National Grid data

bg <- terra::rast('data/Prac3_UK_mask.tif')

# Download fractional water body cover at 30-sec resolution:
# Please note that you have to set download=T if you haven't downloaded the data before:

water_30sec <- geodata::landcover(var='water', path='data', download=T)

# Aggregate water body cover to 5-min spatial resolution

water_5min <- terra::aggregate(water_30sec, fact=10, fun='mean')

# Map the 5-min water body cover

plot(water_5min)

# crop and reproject water body cover to British national Grid

# the approx. spatial extent of UK in lon/lat coordinates

extent_uk <- c(-12, 3, 48, 62)

# Crop and reproject

water_5min <- terra::crop(water_5min, extent_uk)
water_5min <- terra::project(water_5min, bg)
water_5min <- terra::mask(water_5min, bg)

# Map the 5-min water body cover for the UK

plot(water_5min)

# store in file

writeRaster(water_5min, 'data/water_5min_UK.tif')
