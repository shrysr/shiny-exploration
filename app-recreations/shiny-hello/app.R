library(shiny)

## Define UI
ui  <- fluidPage(
  titlePanel("Hello Shiny"),

  sidebarLayout(
    sidebarPanel(
      sliderInput("slider1",
                  label = "Number of Bins",
                  min = 1,
                  max = 50,
                  value = 20
                  )
    ),
      mainPanel("",
                plotOutput("histplot")
                )
  )
)


## Define server logic

server <- function(input, output){

  output$histplot <- renderPlot({

    dataset <- faithful$waiting
    bins <- seq(min(dataset), max(dataset), length.out = input$slider1 +1)

    hist(dataset, breaks = bins, col = "blue", border = "white",
         xlab = "Waiting time to next eruption(mins)",
         main = "Histogram of waiting times"
         )
  })

}

## Run the app
shinyApp(ui = ui, server = server)
