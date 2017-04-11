
# global.R -----------------------------------------------------------------

rm(list = ls())

library(shiny)

source("load_data.R")
source("true_ggmap.R")
source("ggplot.R")


tbl_eq <- load_data()

# ui.R ----------------------------------------------------------------------

ui <- shinyUI(
	
)


# server.R ----------------------------------------------------------------

library(shiny)

server <- shinyServer(function(input, output) {
	
})


# launch-app --------------------------------------------------------------

shiny::shinyApp(ui = ui, server = server)
