
# global.R -----------------------------------------------------------------

rm(list = ls())

library(shiny)
library(leaflet)
library(RColorBrewer)
library(data.table)


#source("load_data.R")
#source("ggmap.R")
#source("ggplot.R")


tbl_eq <- fread("inst/csv/clean_tbl_eq.csv")
#tbl_eq = readRDS("inst/csv/clean_tbl_eq.rds")
min = c(min(tbl_eq$longitude), min(tbl_eq$latitude))
max = c(max(tbl_eq$longitude), max(tbl_eq$latitude))


#tbl_eq = head(tbl_eq_all, 30000)
# ui.R ----------------------------------------------------------------------

ui <- shinyUI(bootstrapPage(
	tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
	leafletOutput("map", width = "100%", height = "100%"),
	absolutePanel(top = 10, right = 20, width = 300,
								# Data preferences
								wellPanel(
									sliderInput("range", "Magnitudes", 0, 5.8,
															# Set starting value to 2.0 to avoid lagging in
															#  generating plot
															value = c(2.5,max(tbl_eq$mag)), step = 0.1
									),
									#selectInput("date", "Year", tbl_eq$year, selected = TRUE)
									sliderInput("date", "Year", 
															min = min(tbl_eq$year),
															max = max(tbl_eq$year),
															value = c(2016,2017),
															step = 1)
								),
								# Color and visualization input
								wellPanel(
									selectInput("colors", "Color Scheme",
															rownames(subset(brewer.pal.info, category %in% c("seq", "div")))
									),
									sliderInput("alpha", "Circle color transparency", 
															min = 0, max = 1, value = 0.7, step = 0.1), 
									checkboxInput("legend", "Show legend", TRUE)
								)
	)
)
	
)


# server.R ----------------------------------------------------------------

server <- shinyServer(function(input, output, session) {
	# Reactive expression for the data subsetted to what the user selected
	
	filteredData <- reactive({
		withProgress(message = 'Filtering data', value = 0.99, {
		tbl_eq[mag %inrange% c(input$range[1],input$range[2])] %>%
			dplyr::filter(year %inrange% c(input$date[1],input$date[2]))})
	})
	
	colorpal <- reactive({
		colorNumeric(input$colors, tbl_eq$mag)
	})
	
	output$map <- renderLeaflet({
		# Use leaflet()
		leaflet() %>% addTiles() %>%
			addProviderTiles(providers$CartoDB.Positron) %>%
			fitBounds(min[1], min[2], max[1], max[2])
	})
	observe({
		pal <- colorpal()
		withProgress(message = 'Making plot', value = 0.99, {
		leafletProxy("map", data = filteredData()) %>%
			clearShapes() %>%
			addCircles(radius = ~10^mag/10, weight = 1, color = "#777777",
								 fillColor = ~pal(mag), fillOpacity = input$alpha, 
								 popup = ~paste("Magnitude", mag)
			)})
	})
	observe({
		proxy <- leafletProxy("map")

		# Remove any existing legend, and only if the legend is
		# enabled, create a new one.
		proxy %>% clearControls()
		if (input$legend) {
			pal <- colorpal()
			proxy %>% addLegend(position = "bottomleft",
													pal = pal, values = tbl_eq$mag, title = "Magnitude"
			)
		}
	})
})


# launch-app --------------------------------------------------------------

shiny::shinyApp(ui = ui, server = server)
