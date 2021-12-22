####################################
#### Google Analytics - server.R ###
####################################

library("shiny")
library("plyr")
library("ggplot2")


setwd("C:/Users/n0237516/OneDrive - Liberty Mutual/@TEMP/Northeatsren/Google_analytics")
load("analytics.Rdata") # load the dataframe

names(analytics) <- tolower(names(analytics))

#shinyServer(
  
  function(input, output) { # server is defined within these parentheses
  
  # prep data once and then pass around the program
  
  passData <- reactive({
    
    analytics <- analytics[analytics[,"date"] %in% seq.Date(input$dateRange[1]
                                                            , input$dateRange[2]
                                                            , by = "days")
                           , ]
    
    analytics <- analytics[analytics[,"hour"] %in% as.numeric(input$minimumTime) : as.numeric(input$maximumTime)
                           , ]
    
    if(class(input$domainShow)=="character"){
      
      analytics <- analytics[analytics[,"domain"] %in% unlist(input$domainShow),]
      
    }
    
    analytics
    
  })
  
  output$monthGraph <- renderPlot({
    
    graphData <- aggregate(data = passData(),
                           cbind(visitors, visits, bounces, timeonsite, hour)~domain+date
                           , FUN=sum)
    
    if(input$outputType == "visitors"){
      
      theGraph <- ggplot(graphData, aes(x = date, y = visitors, group = domain, colour = domain)) + 
        geom_line() +
        ylab("Unique visitors")
      
    }
    
    if(input$outputType == "bounceRate"){
      
      theGraph <- ggplot(graphData, aes(x = date, y = bounces / visits * 100, group = domain, colour = domain)) +
        geom_line() + ylab("Bounce rate %")
      
    }
    
    if(input$outputType == "timeOnSite"){
      
      theGraph <- ggplot(graphData, aes(x = date, y = timeonsite / visits, group = domain, colour = domain)) +
        geom_line() + ylab("Average time on site")
      
    }
    
    if(input$smoother){
      
      theGraph <- theGraph + geom_smooth()
      
    }
    
    print(theGraph)
    
  })
  
  output$hourGraph <- renderPlot({
    
    graphData <- aggregate(data = passData(),
                           cbind(visitors, visits, bounces, timeonsite, hour)~domain+date
                           , FUN=sum)
    
    if(input$outputType == "visitors"){
      
      theGraph <- ggplot(graphData, aes(x = hour, y = visitors, group = domain, colour = domain)) + geom_line() +
        ylab("Unique visitors")
      
    }
    
    if(input$outputType == "bounceRate"){
      
      theGraph <- ggplot(graphData, aes(x = hour, y = bounces / visits * 100, group = domain, colour = domain)) +
        geom_line() + ylab("Bounce rate %")
      
    }
    
    if(input$outputType == "timeOnSite"){
      
      theGraph <- ggplot(graphData, aes(x = hour, y = timeonsite / visits, group = domain, colour = domain)) +
        geom_line() + ylab("Average time on site")
      
    }
        
    if(input$smoother){
      
      theGraph <- theGraph + geom_smooth()
      
    }
    
    print(theGraph)
    
  })
  
  
  output$outTable <- renderTable({ 
    
    table(analytics[analytics[,"networkdomain"] == input$network,"hour"]
         )
    
  })
  
  
  output$textDisplay <- renderText({ 
    
    paste(
      length(seq.Date(input$dateRange[1], input$dateRange[2], by = "days")),
      " days are summarised. There were", sum(passData()$visitors), "visitors in this time period."
    )
    
  })
}
#)