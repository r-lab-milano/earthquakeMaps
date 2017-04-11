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
	tbl_eq
}

