
init_map <- function(tbl_eq, ...) {
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
		ggplot_object <-
			ggplot(mtcars, aes(x = cyl, y = hp)) + 
			geom_point()
		return(ggplot_object)
	}
