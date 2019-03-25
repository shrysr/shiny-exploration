library("easypackages")
libraries("shiny", "shinydashboard", "tidyverse")

## Download file to specific location
system("wget \"https://raw.githubusercontent.com/amrrs/sample_revenue_dashboard_shiny/master/recommendation.csv\" -P ./sales-rev-app/")

recommendation_raw  <- read.csv("./sales-rev-app/recommendation.csv", stringsAsFactors = FALSE, header = TRUE)

## Defining individual components

## header
header <- dashboardHeader(title = "Sales Revenue Dashboard")

## sidebar contents
sidebar <-
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard",
               icon = icon("dashboard"),
               tabName = "dashboard"
               ),
      menuItem("Visit us",
               icon = icon("send", lib = 'glyphicon'),
               href = "https://shrysr.github.io"
               )
    )
  )

## Defining individual rows
frow1 <- fluidRow(
  box(
    valueBoxOutput("value1"),
    valueBoxOutput("value2"),
    valueBoxOutput("value3")

  )
)

frow2 <- fluidRow(
  box(
    title = "Revenue per account",
    status = "primary",
    solidHeader = TRUE,
    collapsible = TRUE,
    plotOutput("revenuebyacct", height = "300px")
  )
)

## combining the defined fluid rows into the dashboard body
body <- dashboardBody(frow1, frow2)

## Defining UI
ui <- dashboardPage(title = "test title", header,sidebar, body)

## Define server logic

server <- function(input, output){
  ## Data manipulation
  total_revenue <- sum(recommendation_raw$revenue)
  sales_account <-
    recommendation_raw %>%
    group_by(Account) %>%
    summarise(value = sum(Revenue)) %>%
    filter(value == max(value))

  prof_prod <-
    recommendation_raw %>%
    group_by(Product) %>%
    summarise(value = sum(Revenue)) %>%
    filter(value == max(value))

  ## Creating valuebox output
  output$value1 <- renderValueBox ({
    valueBox(
      formatC(sales_account$value, format = "d", big.mark= ','),
      paste('Top Account: ', sales_account$Account),
      icon = icon("stats", lib ='glyphicon'),
      color = "purple"
    )
  })

  output$value2 <- renderValueBox({
    valueBox(
      formatC(total_revenue, format = "d", big.mark = ','),
      paste('Top Account: ', sales_account$Account),
      icon = icon("gbp", lib = 'glyphicon'),
      color = "green"
    )
  })

  output$value3 <- renderValueBox({
    valueBox(
      formatC(total_revenue, format = "d", big.mark = ','),
      paste("Top Product: ", prof_prod$Product),
      icon = icon("menu-hamburger", lib = 'glyphicon'),
      color = "yellow"
    )
  })

}

## Run the app
shinyApp(ui = ui, server = server)
