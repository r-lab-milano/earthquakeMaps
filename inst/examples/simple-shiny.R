
library(shiny) 
ui <- 
	fluidPage( 
		numericInput(
			inputId = "num",
			label = "Sample size",
			value = 25), 
		plotOutput(
			outputId = "hist"
		) 
	)
server <- 
	function(input, output) { 
		output$hist	<- renderPlot({
			hist(rnorm(
				input$num
			)) 
		}) 
	}
shinyApp(ui = ui, server = server)
