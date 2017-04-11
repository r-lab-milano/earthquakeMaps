# global.R -----------------------------------------------------------------

rm(list = ls())

library(shiny)
library(shinydashboard)

source("load_data.R")
#source("true_ggmap.R")
#source("ggplot.R")


tbl_eq <- load_data()

# ui.R ----------------------------------------------------------------------

ui <- ui <- dashboardPage(
	dashboardHeader(title = "Filters"),
	dashboardSidebar(
		sliderInput("range", "Years:", min = min(tbl_eq$year), max = max(tbl_eq$year), value = c(2010, 2015), step = 1 ),
		sliderInput("range", "Magnitudo:", min = min(tbl_eq$mag), max = max(tbl_eq$mag), value = c(1, 2), step = 0.5 )
	),
	dashboardBody(
		# Boxes need to be put in a row (or column)
		fluidRow(
			box(plotOutput("plot1", height = 250))
		)
	)
)



# server.R ----------------------------------------------------------------

library(shiny)

server <- function(input, output) {
	set.seed(122)
	histdata <- rnorm(500)
	
	output$plot1 <- renderPlot({
		data <- histdata[seq_len(input$slider)]
		hist(data)
	})
}


# launch-app --------------------------------------------------------------

shiny::shinyApp(ui = ui, server = server)