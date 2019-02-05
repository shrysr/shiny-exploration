library("easypackages")
libraries("shiny", "tidyverse")


## Define UI
ui  <- fluidPage(
    titlePanel("R's in-built Database explorer"),

  fluidRow(
    column(2,
           "Input",
           selectInput("dataset", 
                       label = "Select Dataset",
                       choices = ls("package:datasets")
                       )
           ),
    column(10,
           verbatimTextOutput("summary"),
           fluidRow(
             verbatimTextOutput("glimpse")
                         ))

    )
)       


## Define server logic

server <- function(input, output){

  output$summary = renderPrint({
    dataset <- get(input$dataset, "package:datasets", inherits = FALSE)
    summary(dataset)
  })

  output$table = renderTable({
    dataset <- get(input$dataset, "package:datasets", inherits = FALSE)
    dataset
  })

  output$glimpse = renderPrint({
    dataset <- get(input$dataset, "package:datasets", inherits = FALSE)
    glimpse(dataset)
  })
    
}



## Run the app
shinyApp(ui = ui, server = server)
