library(poispkgs)

logged <- st_read('input/log17-YearHarvest-All-UTM8.gpkg') %>%
  st_make_valid %>%
  st_cast("POLYGON") %>%
  rmapshaper::ms_simplify(keep = 0.01) %>%
  st_transform(4326)

# centroid <- st_centroid(logged %>% st_union %>% st_geometry) %>% as.vector()

saveRDS(logged, 'input/logged.rds')
saveRDS(centroid %>% st_transform(4326) %>% st_coordinates, 'input/centroid.rds')
