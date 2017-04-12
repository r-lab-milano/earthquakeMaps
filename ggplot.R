## 

#require(dplyr)
require(ggplot2)

# df <- read.table('./inst/csv/clean_tbl_eq.csv', sep = ',', head = T , stringsAsFactors = FALSE)
# 
# 
# dft <- df %>% mutate(
#     depth_f = cut(depth , breaks = c(0, 2 , 4, 8, Inf),include.lowest = T ),
#     mag_f = cut(mag , breaks = c(0, 3, 5, Inf) ,include.lowest = T),
#     lat_f = cut(latitude , breaks = pretty(latitude, n = 3)),
#     lon_f = cut(longitude , breaks = pretty(longitude, n = 3))
#     
# ) %>% 
#     tbl_df()



violin_plot <- 
	function(
		tbl_eq,
		x = x_var,
		y = y_var,
		xrange = range(tbl_eq$longitude),
		yrange = range(tbl_eq$latitude), 
		timeRange = range(tbl_eq$year),
		magnitudeRange = range(tbl_eq$mag),
		depthRange = range(tbl_eq$depth),
		...
	) {
		
		ggplot_object <-
			ggplot(data = filterData(tbl_eq, xrange, yrange, timeRange, magnitudeRange, depthRange), 
						 aes(x, y)) + 
			geom_violin() + 
			coord_flip()
		
		print(ggplot_object)
	}







# 
# ggplot(dft , aes(lat_f, mag)) + geom_violin() + coord_flip()
# 
# 
# 
# ggplot(dft , aes(lon_f, mag)) + geom_violin()
# ggplot(dft , aes(lat_f, depth)) + geom_violin() + coord_flip()
# ggplot(dft , aes(lon_f, depth)) + geom_boxplot() #geom_violin()
# 
# ggplot(dft, aes(latitude, longitude)) +  
#     stat_binhex() +
#     facet_grid(aes(mag_f, depth_f))