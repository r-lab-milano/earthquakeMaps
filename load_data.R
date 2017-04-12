load_data <- function() {
	tbl_eq <- read.table(file.path("./inst/csv", "eventi-rlab-dal85al2017.csv"), 
											 header = T, sep = ";", dec = ".", 
											 stringsAsFactors = FALSE)
	tbl_eq <- dplyr::tbl_df(tbl_eq)
	colnames(tbl_eq) <- c("utc_time", "latitude"  , "longitude"  , "depth"     , "mag"      , "source", "X" )

	
	# Data cleaning
	tbl_eq <- within(tbl_eq, {
		X <- NULL
		date <- as.Date(utc_time)
		year <- as.integer(strftime(utc_time, format = "%Y"))
		mag <- as.numeric(sub("(.*\\..*)--.*", "\\1", mag ))
	})
	tbl_eq <- tbl_eq[, c("latitude", "longitude", "depth", "mag", "year")]

	# Data integration for ggplot
	
	tbl_eq <- tbl_eq %>% mutate(
		depth_f = cut(depth , breaks = c(0, 2 , 4, 8, Inf),include.lowest = T ),
		mag_f = cut(mag , breaks = c(0, 3, 5, Inf) ,include.lowest = T),
		lat_f = cut(latitude , breaks = pretty(latitude, n = 3)),
		lon_f = cut(longitude , breaks = pretty(longitude, n = 3))
		
	) %>% 
		tbl_df()
	
	tbl_eq
}

