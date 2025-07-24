#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Sample size simulation"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("n",
                        "Sample size:",
                        min = 10,
                        max = 100,
                        value = 30),
            numericInput("m0", "Mean under the null hypothesis:", 71, min = 50, max = 100),
            numericInput("ma", "Mean of practical importance:", 75, min = 50, max = 100),
            numericInput("sd", "Standard deviation:", 10, min = 5, max = 25)
        ),
        

        # Show a plot of the generated distribution
        mainPanel(
          plotOutput("nullPlot"),
          plotOutput("altPlot")
          )
        )
    )

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$nullPlot <- renderPlot({
        # generate plot based on input$n from ui.R

        semean = input$sd / sqrt(input$n)

        g1 <- ggplot(NULL, aes(c(50, 90))) +
          geom_line(stat = "function", fun = dnorm, args = list(mean = input$m0, sd = semean), xlim = c(50, 90))

        g1
            })

    output$altPlot <- renderPlot({
      # generate plot based on input$n from ui.R
      
      semean = input$sd / sqrt(input$n)
      
      g2 <- ggplot(NULL, aes(c(50, 90))) +
        geom_line(stat = "function", fun = dnorm, args = list(mean = input$ma, sd = semean), xlim = c(50, 90))
      
      g2
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
