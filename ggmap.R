library(dplyr)
library(ggmap)

# tbl_eq <- load_data()

init_map <- function(tbl_eq, ...) {
  getBoundaries <- function(tbl_eq) {
    boundaries <- tbl_eq %>% summarise(topLat = max(latitude), bottomLat = min(latitude),
                                       topLon = max(longitude), bottomLon = min(longitude))
    c(boundaries$bottomLon,
      boundaries$bottomLat,
      boundaries$topLon,
      boundaries$topLat)
  }
  get_map(location = tbl_eq %>% getBoundaries(),
          source = "google")
          #maptype = "hybrid",
          #crop = FALSE
}

# map_eq <- init_map(tbl_eq)

plot_map <- 
  function(
    tbl_eq,
    map_eq = map_eq, 
    xrange = range(tbl_eq$longitude),
    yrange = range(tbl_eq$latitude), 
    timeRange = range(tbl_eq$year),
    magnitudeRange = range(tbl_eq$mag),
    depthRange = range(tbl_eq$depth),
    ...
  ) {
    
    ggplot_object <-
      ggmap(map_eq) + # xlim(xrange) + ylim(yrange) + 
      geom_point(data = filterData(tbl_eq, xrange, yrange, timeRange, magnitudeRange, depthRange), 
      					 alpha = 0.7,
                 aes(x = longitude, y = latitude, colour = mag)) +
      scale_colour_gradient("Legend_label",
                            low = "#1E6AA8", high = "#F54242") +
    	 	theme ( 
    		legend.position = c(0.05, 0.05), # put the legend INSIDE the plot area
    		legend.justification = c(0, 0),
    		# legend.background = element_rect(colour = F, fill = "white"),
    		# legend.key = element_rect (fill = F, colour = F),
    		panel.grid.major = element_blank (), # remove major grid
    		panel.grid.minor = element_blank (),  # remove minor grid
    		axis.text = element_blank (), 
    		axis.title = element_blank (),
    		axis.ticks = element_blank ()
    	) 
    
    print(ggplot_object)
  }


filterData <- function(tbl_eq, xrange, yrange, timeRange, magnitudeRange, depthRange) {
  tbl_eq %>%
    filter(between(longitude, xrange[1], xrange[2]) &
             between(latitude, yrange[1], yrange[2]) &
             between(year, timeRange[1], timeRange[2]) & 
             between(mag, magnitudeRange[1], magnitudeRange[2]) &
             between(depth, depthRange[1], depthRange[2]))
}

# plot_map(tbl_eq, map_eq, timeRange = c(2015,2015))
