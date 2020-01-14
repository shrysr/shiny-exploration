
# Table of Contents

1.  [Introduction](#org7d711bd)
2.  [References](#org0572e52)
3.  [Shiny Tutorials - Rstudio <code>[5/6]</code>](#orgf2c80bb)
    1.  [Lesson 1](#org03376e7)
        1.  [App description and Readme](#org472f226)
        2.  [Installing the shiny library](#org9518753)
        3.  [Running in-built shiny examples](#orgd9a587a)
        4.  [app-01](#org619f1c5)
    2.  [Lesson 2](#org8427540)
        1.  [Starting with custom app](#orgafe3929)
        2.  [Test app for formatting difference highlight](#org7723c92)
        3.  [Testing knowledge. See app-02](#org679c998)
    3.  [Lesson 3 Multiple columns](#orgee94d9c)
        1.  [Re-implementing example. See app-03](#org8b40cc0)
        2.  [Init censusVis task. See app-04](#orgb7bd268)
    4.  [Lesson 4 : reactive ouput display](#orga6e1e3d)
        1.  [Reactive censusViz task. See census-app](#org710099c)
        2.  [Test: passing a list to the input choices](#orge7ec75f)
    5.  [Lesson 5: more complex reactive output](#org80f8b69)
        1.  [Testing the helpers.R script for a chloropleth map](#org024cd27)
        2.  [Setting up chloropleth output in shiny app](#org29bcdb5)
    6.  [Lesson 6: stockVis app](#orga2111f6)
4.  [Recreating in-built Shiny examples <code>[2/3]</code>](#orgf991e8a)
    1.  [Eg 1 Hello Shiny. See hello-shiny](#org3899a80)
    2.  [Eg 2 Shiny text. See shiny-text-eg2](#orgf1d7c25)
        1.  [Base Example](#org830c5a6)
    3.  [Eg 6 - tabsets. See tabsets-eg-6](#orgd09f70d)
5.  [Dataset exploration app <code>[0/1]</code>](#orge4fcdd4)
    1.  [Switching to dashboard library](#orga299dd0)
        1.  [Loading libraries](#orgfa98ea4)
        2.  [UI](#org94df20f)
        3.  [Server](#org30244cc)
        4.  [App](#orgdf8561d)
    2.  [Simple Layout - In built R Data Explorer](#org252641c)
    3.  [Shiny app around Rdatasets](#orgdcff6ec)
        1.  [Introduction](#org45690c2)
        2.  [Resources and References](#org3f185b4)
6.  [Shiny Dashboard init](#orgbcff2b9)
    1.  [References and notes](#org5cc7322)
    2.  [Installing shiny dashboard](#org029bd6a)
    3.  [Basic app &#x2013; Init. See dashboard-01](#orgce95f3d)
    4.  [Notes on the structure of a dashboard: Rstudio documentation link](#orge5400a3)
        1.  [Main components : header, sidebar, body -> defined for `dashboardPage()`](#org5f54b0b)
    5.  [Experimenting with structures](#orgdcbc01d)
        1.  [Dropdown menu items (static) : messages, tasks, notifications](#org623fdf2)
        2.  [Dropdown menu for messages with Dynamic message items](#org68b46a7)
7.  [Sales revenue app - Shiny dashboard](#orgbd49927)
    1.  [Reference link](#orgb54832c)
    2.  [replicating the code](#orgbb991b0)
        1.  [Loading libraries](#org87cee5b)
        2.  [Downloading raw csv and loading into variable](#org63f93af)
        3.  [Init dashboard](#org9113d83)



<a id="org7d711bd"></a>

# Introduction

This [repo](https://github.com/shrysr/shiny-exploration) will serve as a learning and exploration ground to build shiny apps from the ground-up. It will include references, notes and the scripts to reproduce the apps.

Planned Approach:

-   Re-implement examples that I find from scratch, and in parallel explore other aspects and variations of the code.
-   Apply the concepts learned to develop my own shiny apps.
-   Tools used:
    -   Emacs and Org-mode (source blocks in Org-babel) have been used to create this document and scripts, ala Literate programming.
    -   Source blocks are tangled into respective app folders and RStudio was used to quickly run and reload apps for testing. (This is just more convenient than launching the web browser from Emacs.)


<a id="org0572e52"></a>

# References

The references below were instrumental in the learning procedure and also function as a source of inspiration.

Note: Relevant references and links are also placed alongside the code in each section.

1.  Rstudio documentation [link](https://shiny.rstudio.com/tutorial/)
    -   Free video tutorials from Datacamp sponsored by Rstudio. There are links to advanced articles, as well as written tutorials. This is a good resource to get started.
2.  Sales revenue dashboard with Rshiny and ShinyDashboard [link](https://datascienceplus.com/building-a-simple-sales-revenue-dashboard-with-r-shiny-shinydashboard/)


<a id="orgf2c80bb"></a>

# Shiny Tutorials - Rstudio <code>[5/6]</code>

Re-implementing [Rstudio's tutorials](https://shiny.rstudio.com/tutorial/) with minor tweaks and additional explorations in some areas.


<a id="org03376e7"></a>

## DONE Lesson 1


<a id="org472f226"></a>

### App description and Readme

    Title: Hello Shiny! - Lesson 1 of Rstudio tutorials
    Author: Shreyas
    AuthorUrl: http://www.rstudio.com/
    License: MIT
    DisplayMode: Showcase
    Tags: getting-started
    Type: Shiny

    This app is a reproduction of lesson 1 of the official Rstudio tutorials.


<a id="org9518753"></a>

### Installing the shiny library

    install.packages("shiny")


<a id="orgd9a587a"></a>

### Running in-built shiny examples

    runExample("01_hello")


<a id="org619f1c5"></a>

### [app-01](file:///app-01/)

    library(shiny)

    # Define UI for app that draws a histogram ----
    ui <- fluidPage(

      # App title ----
      titlePanel("Hello Shiny!"),

      # Sidebar layout with input and output definitions ----
      sidebarLayout(

        # Sidebar panel for inputs ----
        sidebarPanel(

          # Input: Slider for the number of bins ----
          sliderInput(inputId = "bins",
                      label = "Number of bins:",
                      min = 1,
                      max = 50,
                      value = 30)

        ),

        # Main panel for displaying outputs ----
        mainPanel(

          # Output: Histogram ----
          plotOutput(outputId = "distPlot")

        )
      )
    )

    # Define server logic required to draw a histogram ----
    server <- function(input, output) {

      # Histogram of the Old Faithful Geyser Data ----
      # with requested number of bins
      # This expression that generates a histogram is wrapped in a call
      # to renderPlot to indicate that:
      #
      # 1. It is "reactive" and therefore should be automatically
      #    re-executed when inputs (input$bins) change
      # 2. Its output type is a plot

      output$distPlot <- renderPlot({

        x    <- faithful$waiting
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        hist(x, breaks = bins, col = "#75AADB", border = "white",
             xlab = "Waiting time to next eruption (in mins)",
             main = "Histogram of waiting times")

        })

    }

    # Create Shiny app ----
    shinyApp(ui = ui, server = server)


<a id="org8427540"></a>

## DONE Lesson 2


<a id="orgafe3929"></a>

### Starting with custom app

    library(shiny)

    ## Define UI
    ui  <- fluidPage(

        titlePanel("This is the title"),

        sidebarLayout(
            sidebarPanel("Hello panel",
                         h2("This is h2 title in the sidepanel")),
            mainPanel("main panel",
                      h1("Another title in h1", align = "center")
                      ),
    #        position = "right"
        )

    )
    ## Define server logic

    server <- function(input, output){


    }



    ## Run the app
    shinyApp(ui = ui, server = server)


<a id="org7723c92"></a>

### Test app for formatting difference highlight

    library(shiny)

    ui <- fluidPage(
      titlePanel("My Shiny App"),
      sidebarLayout(
        sidebarPanel(),
        mainPanel(
          p("p creates a paragraph of text."),
          p("A new p() command starts a new paragraph. Supply a style attribute to change the format of the entire paragraph.", style = "font-family: 'times'; font-si16pt"),
          strong("strong() makes bold text."),
          em("em() creates italicized (i.e, emphasized) text."),
          br(),
          code("code displays your text similar to computer code"),
          div("div creates segments of text with a similar style. This division of text is all blue because I passed the argument 'style = color:blue' to div", style = "color:blue"),
          br(),
          p("span does the same thing as div, but it works with",
            span("groups of words", style = "color:blue"),
            "that appear inside a paragraph.")
        )
      )
    )


    ## Run the app
    shinyApp(ui = ui, server = server)


<a id="org679c998"></a>

### Testing knowledge. [See app-02](file:///app-02/)

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


<a id="orgee94d9c"></a>

## DONE Lesson 3 Multiple columns


<a id="org8b40cc0"></a>

### Re-implementing example. [See app-03](file:///app-03/)

    library(shiny)

    ## Define UI
    ui  <- fluidPage(
      titlePanel("Basic widget exploration"),

      fluidRow(

        column(2,
               h3("buttons"),
               actionButton("action007", label ="Action"),
               br(),
               br(),
               submitButton("Submit")
               ),
        column(2,
               h3("Single Checkbox"),
               checkboxInput("checkbox", "Choice A", value = T)
               ),
        column(3,
               checkboxGroupInput("checkGroup",
                                  h3("checkbox group"),
                                  choices = list("Choice 1" = 1,
                                                 "Choice 2" = 2,
                                                 "Choice 3" = 3
                                                 ),
                                  selected = 1
                                  )
               ),
        column(2,
               dateInput("date",
                         h3("date input"),
                         value = ""
                         )
               )

      ),
      ## Inserting another fluid row element
      fluidRow(

        column(2,
               radioButtons("radio",
                            h3("Radio Buttons"),
                            choices = list("choice 1" = 1,
                                           "choice 2" = 2,
                                           "Radio 3"  = 3
                                           ),
                            selected =1
                            )
               ),

        column(2,
               selectInput("select",
                           h3("Select box"),
                           choices = list("choice 1" = 1,
                                          "choice 2" = 2,
                                          "choice 3" = 3
                                          ),
                           selected = 1
                           )
               ),
        column(2,
               sliderInput("slider1",
                           h3("Sliders"),
                           min = 0,
                           max = 100,
                           value = 50
                           ),

               sliderInput("slider2",
                           h3("Another Slider"),
                           min = 50,
                           max = 200,
                           value = c(60,80)
                           )
               ),
        column(2,
               selectInput("selectbox1",
                         h3("select from drop down box"),
                         choices = list("choice 1" = 22,
                                        "choice 2" = 2,
                                        "choice fake 3" = 33
                                        ),
                         selected = ""
                         )
               )

      ),
      fluidRow(
        column(3,
               dateRangeInput("daterange",
                              h3("Date range input")
                              )
               ),

        column(3,
               fileInput("fileinput",
                         h3("Select File")
                         )
               ),

        column(3,
               numericInput("numinput",
                            h3("Enter numeric value"),
                            value = 10
                            )
               ),
        column(3,
               h3("help text"),
               helpText("Hello this is line one.",
                        "This is line 2..\n",
                        "This is line 3."
                        )
               )
      )
    )


    ## Define server logic

    server <- function(input, output){


    }



    ## Run the app
    shinyApp(ui = ui, server = server)


<a id="orgb7bd268"></a>

### Init censusVis task. [See app-04](file:///app-04/)

    library(shiny)

    ## Define UI
    ui  <- fluidPage(
      titlePanel("censusViz"),

      sidebarLayout(
        sidebarPanel(
          helpText("Create demographic maps with information form the 2010 US Census"),
          selectInput("inputbox1",
                      h2("Choose variable to display:"),
                      choices = list("Percent White" = 1,
                                     "Percent Black" = 2,
                                     "Percent Hispanic" = 3,
                                     "Percent Asian" = 4
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
        mainPanel("")
      )
    )


    ## Define server logic

    server <- function(input, output){


    }



    ## Run the app
    shinyApp(ui = ui, server = server)


<a id="orga6e1e3d"></a>

## DONE Lesson 4 : reactive ouput display


<a id="org710099c"></a>

### Reactive censusViz task. [See census-app](file:///census-app/)

    library("easypackages")
    libraries("shiny", "dplyr", "stringr")

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


<a id="orge7ec75f"></a>

### Test: passing a list to the input choices

-   Note taken on <span class="timestamp-wrapper"><span class="timestamp">[2019-02-05 Tue 11:04] </span></span>
    Testing to see if a list defined in a variable can be passed as choices. This is possible.

    library("easypackages")
    libraries("shiny", "dplyr", "stringr")

    ## List to pass into the input box choices
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


<a id="org80f8b69"></a>

## DONE Lesson 5: more complex reactive output


<a id="org024cd27"></a>

### Testing the helpers.R script for a chloropleth map

    library(easypackages)
    libraries("maps", "mapproj")
    source("./census-app-02/01_scripts/helpers.R")
    counties  <- read_rds("./census-app-02/00_data/counties.rds")
    percent_map(counties$white, "darkgreen", "% White")


<a id="org29bcdb5"></a>

### Setting up chloropleth output in shiny app

Using the dataset `counties.rds` collected with the `Uscensus2010` R package. [Download link](http://shiny.rstudio.com/tutorial/written-tutorial/lesson5/census-app/data/counties.rds).

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


<a id="orga2111f6"></a>

## TODO Lesson 6: stockVis app


<a id="orgf991e8a"></a>

# Recreating in-built Shiny examples <code>[2/3]</code>


<a id="org3899a80"></a>

## DONE Eg 1 Hello Shiny. [See hello-shiny](file:///hello-shiny/)

    library(shiny)

    ## Define UI
    ui  <- fluidPage(
      titlePanel("Hello Shiny"),

      sidebarLayout(
        sidebarPanel(
          sliderInput("slider1",
                      label = "Number of Bins",
                      min = 1,
                      max = 50,
                      value = 20
                      )
        ),
          mainPanel("",
                    plotOutput("histplot")
                    )
      )
    )


    ## Define server logic

    server <- function(input, output){

      output$histplot <- renderPlot({

        dataset <- faithful$waiting
        bins <- seq(min(dataset), max(dataset), length.out = input$slider1 +1)

        hist(dataset, breaks = bins, col = "blue", border = "white",
             xlab = "Waiting time to next eruption(mins)",
             main = "Histogram of waiting times"
             )
      })

    }

    ## Run the app
    shinyApp(ui = ui, server = server)


<a id="orgf1d7c25"></a>

## DONE Eg 2 Shiny text. [See shiny-text-eg2](file:///shiny-text-eg2/)

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
               "cars"   = cars
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


<a id="org830c5a6"></a>

### DONE Base Example


<a id="orgd09f70d"></a>

## TODO Eg 6 - tabsets. [See tabsets-eg-6](file:///tabsets-eg-6/)

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


<a id="orge4fcdd4"></a>

# Dataset exploration app <code>[0/1]</code>


<a id="orga299dd0"></a>

## Switching to dashboard library


<a id="orgfa98ea4"></a>

### Loading libraries

    # Loading Libraries
    library("easypackages")
    libraries("tidyverse", "tidyquant", "readxl", "shiny", "shinydashboard", "ISLR", "MASS")


<a id="org94df20f"></a>

### UI

1.  header

        header <- dashboardHeader(title= "R Data set explorer")

2.  sidebar

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

3.  body

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

4.  Assigning UI

        ui  <- dashboardPage(header, sidebar, body)


<a id="org30244cc"></a>

### Server

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


<a id="orgdf8561d"></a>

### App

    ## Run the app
    shinyApp(ui = ui, server = server)


<a id="org252641c"></a>

## Simple Layout - In built R Data Explorer

-   Note taken on <span class="timestamp-wrapper"><span class="timestamp">[2019-02-05 Tue 09:20] </span></span>
    Appears that the sidepanel and mainpanel concepts cannot be used with `fluidRow()` as subcomponents. Instead, it is possible to use only `fluidRow()` to partition the page, and use it to create individual rows within a column. Perhaps this is more flexible in the long run.

    library("easypackages")
    libraries("shiny", "tidyverse")

    ## Define UI
    ui  <- fluidPage(
        titlePanel("R's in-built Database explorer"),

      fluidRow(
        column(2,
               "Input",
               selectInput("dataset",
                           label = "Select Dataset",
                           choices = ls("package:datasets")
                           )
               ),
        column(10,
               verbatimTextOutput("summary"),
               fluidRow(
                 verbatimTextOutput("glimpse")
                             ))
        )
    )

    ## Define server logic

    server <- function(input, output){

      output$summary = renderPrint({
        dataset <- get(input$dataset, "package:datasets", inherits = FALSE)
        summary(dataset)
      })

      output$table = renderTable({
        dataset <- get(input$dataset, "package:datasets", inherits = FALSE)
        dataset
      })

      output$glimpse = renderPrint({
        dataset <- get(input$dataset, "package:datasets", inherits = FALSE)
        glimpse(dataset)
      })

    }

    ## Run the app
    shinyApp(ui = ui, server = server)


<a id="orgdcff6ec"></a>

## TODO Shiny app around Rdatasets


<a id="org45690c2"></a>

### Introduction


<a id="org3f185b4"></a>

### Resources and References

1.  [SO Discusion: List of in-built datasets in R](https://stackoverflow.com/questions/33797666/how-do-i-get-a-list-of-built-in-data-sets-in-r)

**\***


<a id="orgbcff2b9"></a>

# Shiny Dashboard init


<a id="org5cc7322"></a>

## References and notes

1.  Rstudio documentation, getting started with Shiny Dashboard [link](https://rstudio.github.io/shinydashboard/get_started.html)
2.  [There are 2 types of packages](https://shiny.rstudio.com/articles/dashboards.html) available to create dashboards flexdashboard and shiny dashboard.


<a id="org029bd6a"></a>

## Installing shiny dashboard

    install.packages("shinydashboard")


<a id="orgce95f3d"></a>

## Basic app &#x2013; Init. [See dashboard-01](file:///dashboard-01/)

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


<a id="orge5400a3"></a>

## Notes on the structure of a dashboard: [Rstudio documentation link](https://rstudio.github.io/shinydashboard/structure.html)


<a id="org5f54b0b"></a>

### Main components : header, sidebar, body -> defined for `dashboardPage()`

These can be split up into separate variables and fed into the dashboardPage function. This is useful in the case of complex or long programs.

    header  <- dashboardHeader()  # Defining the content of each function into a variable
    sidebar  <- dashboardSiderbar()
    body  <- dashboardBody()

    dashboardPage(header, sidebar, body)

1.  Header

    This will contain the dropdownMenu() items of different types. The types could  could be messages or notifications etc.


<a id="orgdcbc01d"></a>

## Experimenting with structures

Incorporating elements from the structures overview in Rstudio's documentation ([link](https://rstudio.github.io/shinydashboard/structure.html)).


<a id="org623fdf2"></a>

### Dropdown menu items (static) : messages, tasks, notifications

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
        ## Assigning the tab to the tab names and populating individual content
        tabItems(
          tabItem(
            tabName = "dashboard",
            fluidRow(
              ## Note that the objects are encapsulated within a box
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


<a id="org68b46a7"></a>

### TODO Dropdown menu for messages with Dynamic message items


<a id="orgbd49927"></a>

# TODO Sales revenue app - Shiny dashboard


<a id="orgb54832c"></a>

## Reference [link](https://datascienceplus.com/building-a-simple-sales-revenue-dashboard-with-r-shiny-shinydashboard/)


<a id="orgbb991b0"></a>

## replicating the code

-   Note taken on <span class="timestamp-wrapper"><span class="timestamp">[2019-02-06 Wed 10:17] </span></span>


<a id="org87cee5b"></a>

### Loading libraries

    library("easypackages")
    libraries("shiny", "shinydashboard", "tidyverse")


<a id="org63f93af"></a>

### Downloading raw csv and loading into variable

    ## Download file to specific location
    system("wget \"https://raw.githubusercontent.com/amrrs/sample_revenue_dashboard_shiny/master/recommendation.csv\" -P ./sales-rev-app/")

Reading in the csv file

    recommendation_raw  <- read.csv("./sales-rev-app/recommendation.csv", stringsAsFactors = FALSE, header = TRUE)


<a id="org9113d83"></a>

### Init dashboard

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
