library(shiny)
library(tidyverse)

## Define UI
ui  <- fluidPage(
  titlePanel("Shiny text"),

  sidebarLayout(
    sidebarPanel(
      selectInput("dataset_choice",
                  label = "Choose a dataset",
                  choices = c("rock", "diamonds", "cars"),
                  #value = ""
                  ),
      numericInput("observation_number",
                   label = "Choose number of observations to display",
                   value = 10
                   )
    ),
    mainPanel(

      verbatimTextOutput("summary"),

      tableOutput("view")
    )
  )
)


## Define server logic

server <- function(input, output){

  datasetInput <- reactive({
    switch(input$dataset_choice,
           "rock" = rock,
           "diamonds"  = diamonds,
           "cars"   = mtcars
           )
  })

  output$summary <- renderPrint({
    datasetInput() %>% summary()
  })

  output$view <- renderTable({
    datasetInput() %>% head(n = input$observation_number)
  })
}



## Run the app
shinyApp(ui = ui, server = server)
