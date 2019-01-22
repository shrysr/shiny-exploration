library(shiny)

## Define UI
ui  <- fluidPage(

    titlePanel("This is the title"),

    sidebarLayout(
        sidebarPanel("sidebar panel"),
        mainPanel("main panel"),
        position = "right"
    )

)


## Define server logic

server <- function(input, output){

    
}



## Run the app
shinyApp(ui = ui, server = server)
