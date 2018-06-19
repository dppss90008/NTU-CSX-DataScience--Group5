library(shiny)
library(ggplot2)
library(magrittr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  FB_Taipei <- read.csv("FaceBookAPI-Taipei.csv")
  
  output$TrendPlot <- renderPlot({
    if(input$Candi==4){
      mood = input$mood %>% as.character()
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
  
  

  
  
  output$BoxPlot <- renderPlot({
    
    P1 <- ggplot(FB_Taipei, aes(x=Candidate, y=eval(parse(text = input$mood2 %>% as.character())),color = Candidate)) + 
      scale_color_manual(values=c("blue", "green", "red"))
    if(input$outlier == 0){
      P2 = P1 +  geom_boxplot()
      P2
    }else if(input$outlier == 1){
      Q = FB_Taipei$like %>% as.numeric()%>% quantile(.,0.75)
      Q = Q*2
      P3 = P1 + geom_boxplot(outlier.shape = NA)+ylim(low=0, high=Q)
      P3
    }
    
    
  })
  
})
