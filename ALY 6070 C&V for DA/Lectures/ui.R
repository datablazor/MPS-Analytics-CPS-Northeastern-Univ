###############################
### Google Analytics - ui.R ###
###############################

library(shiny) 

fluidPage(
  headerPanel("Google Analytics Example for Week 5"), 
  sidebarLayout( 
    
  
  sidebarPanel( 
    
    dateRangeInput(inputId = "dateRange",  
                   label = "Date range", 
                   start = "2013-04-01",
                   end = "2014-04-01"
    ),
    hr(),
    
    sliderInput(inputId = "minimumTime",
                label = "Hours of interest- minimum",
                min = 0,
                max = 23,
                value = 0,
                step = 1),
    hr(),
    
    sliderInput(inputId = "maximumTime",
                label = "Hours of interest- maximum",
                min = 0,
                max = 23,
                value = 23,
                step = 1),
    hr(),
    
    checkboxInput(inputId = "smoother",
                  label = "Add smoother?",
                  value = FALSE),
    hr(),
    
    checkboxGroupInput(inputId = "domainShow",
                       label = "Show NHS and other domain (defaults to all)?",
                       choices = list("NHS users" = "NHS",
                                      "Other" = "Other")
                       ),
    hr(),
    
    radioButtons(inputId = "outputType",
                 label = "Output required",
                 choices = list("Visitors" = "visitors",
                                "Bounce rate" = "bounceRate",
                                "Time on site" = "timeOnSite")),
    hr(),
    
    selectInput(inputId = "network"
                , label = "Choose domain"
                , choices = analytics[,"networkdomain"]
                ),
    hr()
    
  ),
  mainPanel(
    tabsetPanel( 
      tabPanel("Summary", textOutput("textDisplay")), 
      tabPanel("Monthly figures", plotOutput("monthGraph")),
      tabPanel("Hourly figures", plotOutput("hourGraph")),
      tabPanel("Random table",tableOutput("outTable"))
    )
  )
))