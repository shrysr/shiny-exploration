library(shiny)
library(shinythemes)

## Define UI
ui  <- fluidPage(
  themeSelector(),
  titlePanel("Using tabsets"),

  sidebarLayout(
    sidebarPanel(
      radioButtons("dist_type",
                   "Distribution type",
                   choices = c("Normal" = "norm",
                               "Uniform" = "unif",
                               "Log-normal" = "lnorm",
                               "Exponential" = "exp"
                               )
                   ),
      sliderInput("slider1",
                  label = "Number of observations",
                  min = 1,
                  max = 1000,
                  value = 500
                  )
    ),

    mainPanel(

      tabsetPanel(type = "tabs",
                  tabPanel(title = "Plot", plotOutput("plot1")),
                  tabPanel(title = "Summary", verbatimTextOutput("vbto1_summary")),
                  tabPanel(title = "Table", tableOutput("tabl1"))
                  )
    )
  )
)


## Define server logic

server <- function(input, output){
  d <- reactive({
    dist <- switch(input$dist_type,
           norm = rnorm,
           unif = runif,
           lnorm = rlnorm,
           exp = exp
#           rnorm
           )

    dist(input$slider1)
  })

  output$plot1 <- renderPlot({
    dist <- input$dist_type
    n <- input$slider1

    hist(d(),
         main = paste("r", dist, "(", n, ")", sep = ""),
         col = "blue", border = "white")
  })

  output$vbto1_summary <- renderText({
    summary(d())
  })

  output$tabl1 <- renderTable({
    d()
  })
}

## Run the app
shinyApp(ui = ui, server = server)
