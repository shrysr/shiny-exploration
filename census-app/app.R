library("easypackages")
libraries("shiny", "dplyr", "stringr")

test_list = list("Percent White" ,
                 "Percent Black",
                 "Percent Hispanic",
                 "Percent Asian"
                 )
## Define UI
ui  <- fluidPage(
  titlePanel("censusViz"),

  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with information form the 2010 US Census"),
      selectInput("inputbox1",
                  h2("Choose variable to display:"),
                  choices = test_list,
                  selected = ""
                  ),
      sliderInput("slider1",
                  h2("Range of interest:"),
                  min = 0,
                  max = 100,
                  value = c(0,100)
                  )
    ),
    mainPanel(h1("Reactive Output"),
              textOutput("selected_var"),
              textOutput("slider_range")
              )
  )
)


## Define server logic

server <- function(input, output){

  output$selected_var <- renderText({
    str_glue("Selected option is {input$inputbox1} ")
  })

  output$slider_range <- renderText({
    str_glue("Range selected from \n {input$slider1[1]} to {input$slider1[2]}")
  })
}



## Run the app
shinyApp(ui = ui, server = server)
