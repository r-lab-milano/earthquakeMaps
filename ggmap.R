
init_map <- function(tbl_eq, goffset=0.05,...) {
  
  
  lats <- range(tbl_eq$latitude)
  lons <- range(tbl_eq$longitude)
  
  myLocation <- c(lons[1],lats[1],lons[2],lats[2])+goffset*c(-1,-1,1,1)
  
  
  out <- get_map(location=myLocation,zoom=...)
  
  return(out)
  
}

filterData <- function(tbl_eq, period=range(tbl_eq$year), 
                       magnitudeRange=range(tbl_eq$mag), 
                       depthRange=range(tbl_eq$depth)) {
  tbl_eq %>%
    filter(between(year, period[1], period[2]) & 
             between(mag, magnitude[1], magnitude[2]) &
             between(depth, depthRange[1], depthRange[2]))
}

plot_map <- 
  function(
    tbl_eq, 
    map_eq = init_map(tbl_eq, goffset = 0.05), 
    period = range(tbl_eq$year),
    mag = range(tbl_eq$mag),
    depth = range(tbl_eq$detph),
    ...
  ) {
    
    ggplot_object <-
      ggmap(map_eq) + 
      geom_point(data = filterData(tbl_eq, period, mag, depth), alpha = 0.5,
                 aes(x = longitude, y = latitude, colour = depth, size = mag)) +
      scale_colour_gradient("Legend_label",
                            low = "#1E6AA8", high = "#F54242")
  }
