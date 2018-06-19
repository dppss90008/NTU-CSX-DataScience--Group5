library(shiny)
library(ggplot2)
library(magrittr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  FB_Taipei <- read.csv("FaceBookAPI-Taipei.csv")
  
  output$TrendPlot <- renderPlot({
    if(input$Candi==4){
      ggplot(data=FB_Taipei, aes(x=time%>% as.Date(), y=eval(parse(text = input$mood %>% as.character())), color=Candidate))+geom_point(size=3)+xlab("time")+scale_color_manual(values=c("blue", "green", "black"))
    }else{
      names = input$Candi %>% as.character()
      mood = input$mood %>% as.character()
      if(input$line==TRUE){
        qplot(time %>% as.Date(),eval(parse(text = input$mood %>% as.character())),data=FB_Taipei[FB_Taipei$Candidate==names,],xlab = "date",ylab=mood,geom = c("point", "smooth"))
      }else{
        qplot(time %>% as.Date(),eval(parse(text = input$mood %>% as.character())),data=FB_Taipei[FB_Taipei$Candidate==names,],xlab = "date",ylab=mood)
      }
    }
    
  })
  
  
})
