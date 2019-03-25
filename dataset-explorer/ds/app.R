# Loading Libraries
library("easypackages")
libraries("tidyverse", "tidyquant", "readxl", "shiny", "shinydashboard", "ISLR", "MASS")

header <- dashboardHeader(title= "R Data set explorer")

sidebar <- dashboardSidebar(
    sidebarMenu(
      menuItem("In-built data sets",
               tabName = "inbuilt_datasets",
               icon = icon("dashboard")
               ),
      menuItem("Rdatasets",
               tabName = "rdatasets",
               icon = icon("dashboard")
               )
    )
)

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "inbuilt_datasets",
      fluidRow(

        box(title = "Input",
            selectInput("dataset",
                        label = "Select Dataset",
                        choices = c(ls("package:datasets") ,
                                    data(package = "MASS")$results %>% as.tibble %>% .$Title
                                    )
                        )
           ),

        box(title = "Summary",
            verbatimTextOutput("summary"),
            fluidRow(
              box(
                title = "Data Glimpse",
                verbatimTextOutput("glimpse")
              )
            )
        )
      )
      )
     ),
  tabItem(
    tabName = "rdatasets",
    h2("Rdatasets"),
    fluidRow(

      box(title = "Input",
          selectInput("rdataset",
                      label = "Select from RDatasets",
                      choices = data(package = "MASS")$results %>% as.tibble %>% .$Title
                        ),

      box(title = "Summary",
            verbatimTextOutput("summary_rdatasets"),
            fluidRow(
              box(
            title = "Data Glimpse"),
          verbatimTextOutput("glimpse_rdatasets")
          )
          )
    )
  )
  )
)

ui  <- dashboardPage(header, sidebar, body)

## Define server logic

server <- function(input, output){

  output$summary = renderPrint({
    dataset <- get(input$dataset, "package:datasets", inherits = FALSE)
    summary(dataset)
  })

  ## output$table = renderTable({
  ##   dataset <- get(input$dataset, "package:datasets", inherits = FALSE)
  ##   dataset
  ## })

  output$glimpse = renderPrint({
    dataset <- get(input$dataset, "package:datasets", inherits = FALSE)
    glimpse(dataset)
  })

}

## Run the app
shinyApp(ui = ui, server = server)
