library(shiny)

## Define UI
ui  <- fluidPage(
    titlePanel("My Shiny App"),

    sidebarLayout(
        sidebarPanel(h1("Installation"),
                     p("Shiny is available on CRAN, so you can install it the usual way using:"),
                     br(),
                     code('install.packages("shiny")'),
                     img(src="rstudio.png", height = 70, width = 200),
                     p("Shiny is a product of ", a("Rstudio",
                                                 href="http://www.shiny.rstudio.com"))
                     ),
        mainPanel()
    )
)


## Define server logic
server <- function(input, output){}



## Run the app
shinyApp(ui = ui, server = server)
