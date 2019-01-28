library("easypackages")
libraries("shiny", "dplyr", "stringr", "readr", "maps", "mapproj")


## Reading the counties dataset and glimpsing
source("helpers.R")
counties <- read_rds("./00_data/counties.rds")
counties %>% glimpse()

## Define UI
ui  <- fluidPage(
  titlePanel("censusViz"),

  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with information form the 2010 US Census"),
      selectInput("inputbox1",
                  h2("Choose variable to display:"),
                  choices = list("Percent White" ,
                                 "Percent Black",
                                 "Percent Hispanic",
                                 "Percent Asian"
                                ),
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
              textOutput("slider_range"),
              plotOutput("map")
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

  output$map  <- renderPlot({

    arg_list  <-  switch(input$inputbox1,
                         "Percent White" = list(counties$white, "darkgreen","% White population"),
                         "Percent Black" = list(counties$black, "black","% Black population"),
                         "Percent Asian" = list(counties$asian, "darkorange","% Asian population"),
                         "Percent Hispanic" = list(counties$hispanic, "pink","% Hispanic population"),
                         )
    
    arg_list$max = input$slider1[2]
    arg_list$min = input$slider1[1]

    do.call(percent_map,arg_list)
    
  })
}



## Run the app
shinyApp(ui = ui, server = server)
