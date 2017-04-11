
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
		map_eq, 
		period,
		mag,
		...
	) {
		# example code: FIX ME!!!
	  
	  
	  
		ggplot_object <- ggmap(maq_eq)
		
			ggplot(mtcars, aes(x = cyl, y = hp)) + 
			geom_point()
		return(ggplot_object)
	}
