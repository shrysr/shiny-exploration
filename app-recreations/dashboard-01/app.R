library("easypackages")
libraries("shiny","shinydashboard", "tidyverse")

## Define UI
ui  <- dashboardPage(
  ## Inserting the 3 components: header, sidebar, body

  dashboardHeader(title = "Basic Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard",
               tabName = "dashboard",
               icon = icon("dashboard")),
      menuItem("Widgets",
               tabName = "widgets",
               icon = icon("th")
               )
    )
  ),
  dashboardBody(
    ## Adding a fluidRow with boxes for plot and slider input
    tabItems(
      tabItem(
        tabName = "dashboard",
        fluidRow(

          box(plotOutput(
            "plot1",
            height = 250
          )),

          box(
            title = "Controls",
            sliderInput("slider1",
                        "Number of observations",
                        min = 1,
                        max = 100,
                        value = 50)
          )
        )
      ),

      tabItem(tabName = "widgets",
              h2("Widgets tab")
              )
    )
  )
)

## Define server logic

server <- function(input, output){
  set.seed(120)
  histdata <- rnorm(1000)

  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider1)]
    hist(data)
  })

}

## Run the app
shinyApp(ui = ui, server = server)
