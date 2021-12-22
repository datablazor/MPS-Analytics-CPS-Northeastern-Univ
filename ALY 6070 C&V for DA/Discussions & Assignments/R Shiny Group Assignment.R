# Communication & Visualization for Data Analytics
# ALY 6070
# Group R Shiny Application
# 02/14/2021
# Sunil Raj Thota, Nalini Macharla, Lakshmi Priya Neelamsetty, Sumadhura Thananki

#-----------------------------------------------------------------------------
# Get and set the working directories
getwd()
setwd('G:/NEU/Coursework/2021 Q1 Winter/ALY 6070 C&V for DA/Discussions & Assignments')
getwd()

# Installed the above packages into the work space
install.packages("gridExtra")
install.packages("shiny")
install.packages("ggplot2")

# Loaded the below libraries into the work space
library(ggplot2)
library(gridExtra) # Required to group the plots in a good way
library(shiny)

nycTreesData <-
  read.csv("NYC 2015 Tree Census Data.csv", header = TRUE)
nycTreesData
View(nycTreesData)
str(nycTreesData)
summary(nycTreesData)
head(nycTreesData)
tail(nycTreesData)

ui <- fluidPage(
  titlePanel("NYC Trees 2015 Census Dashboard"),
  sidebarLayout(sidebarPanel(
    sliderInput(
      inputId = "tree_dbh",
      label = "Number of Trees",
      min = 0,
      max = 450,
      value = 15
    )
  ), mainPanel(plotOutput(outputId = "allPlots")))
)

server <- function(input, output) {
  output$allPlots <- renderPlot({
    p1 <-
      ggplot(nycTreesData, aes(status, health, fill = council.district)) +
      geom_tile() +
      scale_fill_distiller(palette = "RdPu") +
      ggtitle("Correlation between Status and Health") +
      theme(plot.title = element_text(size = 15))
    
    p2 <-
      ggplot(nycTreesData,
             aes(x = user_type, y = borocode, fill = user_type)) +       geom_bar(stat = "identity", width = 0.4) + ggtitle("Borocode vs User Type") +   theme(plot.title = element_text(size = 15))
    p3 <-
      ggplot(nycTreesData, aes(x = guards, y = sidewalk, fill = guards)) +
      geom_bar(stat = "identity", width = 0.4) +
      ggtitle("Sidewalk vs Guards") +
      theme(plot.title = element_text(size = 15))
    
    p4 <-
      ggplot(nycTreesData, aes(x = borocode, fill = borocode)) +
      geom_histogram(color = "white", binwidth = 0.5) +
      ggtitle("NYC Trees Borocode") +
      theme(plot.title = element_text(size = 15))
    grid.arrange(p1, p2, p3, p4, ncol = 2)
  })
}

shinyApp(ui = ui, server = server)
