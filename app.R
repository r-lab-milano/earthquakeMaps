# global.R -----------------------------------------------------------------

rm(list = ls())

library(shiny)
library(shinydashboard)
library(ggmap)
library(dplyr)

source("load_data.R")



tbl_eq <- load_data()
source("ggmap.R")
source("ggplot.R")
 if (!exists("map_eq")) map_eq <- init_map(tbl_eq)

# ui.R ----------------------------------------------------------------------

ui <- ui <- dashboardPage(
	dashboardHeader(title = "R-Lab#2"),
	
	dashboardSidebar(
		sidebarMenu(
			menuItem("Map", tabName = "map_tab", icon = icon("map-marker")),
			menuItem("Plots", icon = icon("bar-chart"), tabName = "plot_tab")
		),
		sliderInput("range", "Years:", 
								min = min(tbl_eq$year), max = max(tbl_eq$year), 
								value = c(1985, 1985) , step = 1,
								animate = animationOptions(interval=3000, loop=F)),
		sliderInput("range_mag", "Magnitudo:", 
								min = min(tbl_eq$mag), max = max(tbl_eq$mag), 
								value = c(2, 6.5)    , step = 0.5 )
	),
	dashboardBody(
		# Boxes need to be put in a row (or column)
		tabItems(
			tabItem(tabName = "map_tab",
							h2("Bove-Vettore fault system"),
							fluidRow(
								box(title = "Earthquakes evolution", status = "primary", plotOutput("map")))
			),
			
			tabItem(tabName = "plot_tab",
							h2("Bove-Vettore fault system"),
							fluidRow(
								box(title = "Magnitude at different Latitudes", status = "primary", plotOutput("plot1")),
								box(title = "Magnitude at different Longitudes", status = "primary", plotOutput("plot2"))
							),
							fluidRow(
								box(title = "Depth at different Latitudes", status = "primary", plotOutput("plot3")),
								box(title = "Depth at different Longitudes", status = "primary", plotOutput("plot4"))
							)
			)
		)
		
	)
)



# server.R ----------------------------------------------------------------

library(shiny)

server <- function(input, output) {
	
	output$map <- renderPlot({
		plot_map(tbl_eq, map_eq,
						 timeRange = input$range,
						 magnitudeRange = input$range_mag)
	})	

		output$plot1 <- renderPlot({
			violin_mag_lat(tbl_eq,  
											timeRange = input$range,
											magnitudeRange = input$range_mag)
		})

		output$plot2 <- renderPlot({
			violin_mag_lon(tbl_eq,  
										 timeRange = input$range,
										 magnitudeRange = input$range_mag)
		})
		
		output$plot3 <- renderPlot({
			violin_dep_lat(tbl_eq,  
										 timeRange = input$range,
										 magnitudeRange = input$range_mag)
		})
		
		output$plot4 <- renderPlot({
			violin_dep_lon(tbl_eq,  
										 timeRange = input$range,
										 magnitudeRange = input$range_mag)
		})
		
}


# launch-app --------------------------------------------------------------

shiny::shinyApp(ui = ui, server = server)
