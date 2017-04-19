# global.R -----------------------------------------------------------------

#rm(list = ls())

library(shiny)
library(shinydashboard)
library(ggmap)
library(dplyr)

source("load_data.R")
#source("ggplot.R")


tbl_eq <- load_data()
source("ggmap.R")
if (!exists("map_eq")) map_eq <- init_map(tbl_eq)
# ui.R ----------------------------------------------------------------------

ui <- ui <- dashboardPage(
	dashboardHeader(title = "Filters"),
	dashboardSidebar(
		sliderInput("range", "Years:", 
								min = min(tbl_eq$year), max = max(tbl_eq$year), 
								value = c(1985, 1985) , step = 1,
								animate = animationOptions(interval=1000, loop=T)),
		sliderInput("range_mag", "Magnitudo:", 
								min = min(tbl_eq$mag), max = max(tbl_eq$mag), 
								value = c(2, 6.5)    , step = 0.5 )
	),
	dashboardBody(
		# Boxes need to be put in a row (or column)
		fluidRow(
			box(plotOutput("plot1", height = 700))
		)
	)
)



# server.R ----------------------------------------------------------------

library(shiny)

server <- function(input, output) {

		output$plot1 <- renderPlot({
		plot_map(tbl_eq, map_eq,
						 timeRange = input$range,
						 magnitudeRange = input$range_mag)
		})
		
}


# launch-app --------------------------------------------------------------

shiny::shinyApp(ui = ui, server = server)
