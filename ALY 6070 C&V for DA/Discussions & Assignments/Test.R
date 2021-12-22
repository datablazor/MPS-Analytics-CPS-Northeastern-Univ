library(shiny)
library(dplyr)
library(shinydashboard)

req(input$DISTRICT)

server <- function(input, output, session) {
  data <- reactive({
    df <- c %>% filter(DISTRICT %in% input$DISTRICT)
  })
  
  output$plot <- renderPlot({
    ggplot(data(), aes(DISTRICT)) + geom_bar() + coord_flip()
  })
}
ui <- basicPage(
  h1("R Shiny Bar Plot"),
  selectInput(
    inputId = "DISTRICT",
    label = "Choose District",
    list(
      "External",
      "West Roxbury",
      "Hyde Park",
      "Jamaica Plain",
      "South End",
      "Brighton",
      "South Boston",
      "Dorchester",
      "Mattapan",
      "Roxbury",
      "East Boston",
      "Charlestown",
      "Downtown"
    )
  ),
  plotOutput("plot")
  
)

shinyApp(ui = ui, server = server)