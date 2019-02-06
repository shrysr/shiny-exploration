library("easypackages")
libraries("shiny","shinydashboard", "tidyverse")

## Define UI
ui  <- dashboardPage(
  ## Inserting the 3 components: header, sidebar, body
  
  dashboardHeader(title = "Basic Dashboard",
                  ##Experimenting with static dropdown menu message items. 
                  dropdownMenu(
                    type = "messages",
                    ## Message items require a 'from' and 'message' argument
                    messageItem(
                      from = "Sales Dept",
                      message = "Sales are steady."
                    ),
                    messageItem(
                      from = "Shop Floor",
                      message = "Job XXX is done"
                    )
                  ),
                  ## Adding static tasks items in dropdown menu
                  dropdownMenu(type = "tasks",
                               taskItem(value = 37,
                                        ## The value denotes the percentage completion
                                        color = "red",
                                        "Test Project 1"
                                        ),
                               taskItem(value = 50,
                                        color = "blue",
                                        "Test Project 2"
                                        )
                               
                               ),

                  dropdownMenu(type = "notifications",
                               notificationItem(
                                 text = "Blah Blah Today is cold",
                                 icon("users")
                               ),
                               notificationItem(
                                 text = "Another notification",
                                 icon("truck"),
                                 status = "success"
                               ),
                               notificationItem(
                                 text = "3rd notification",
                                 icon("exclamation-triangle"),
                                 status = "warning"
                               )
                               )
                  ),
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
