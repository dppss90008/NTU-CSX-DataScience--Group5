library(shiny)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
  "FaceBook",
  
  #### 趨勢圖布局 ####
  tabPanel("趨勢圖",
           sidebarLayout(
      
             sidebarPanel(
               
               # Input: Choose dataset ----
               selectInput("Candi", "Choose a dataset:",
                           choices = list("柯文哲"="柯文哲", "丁守中"="丁守中", "姚文智"="姚文智","全部"=4))
               ,checkboxInput("line", label = "加上趨勢線", value = FALSE),
               radioButtons("mood", label = h3("Radio buttons"),
                            choices = c("like","share","angry","sad","haha","love","wow","sentiment"), 
                            selected = "like")
               
             ), mainPanel(
               
               plotOutput("TrendPlot")
               
             )
           
           )       
    ),
  
  
  #### 盒狀圖布局 ####
  tabPanel("盒狀圖",
           sidebarLayout(
             sidebarPanel(
        
               radioButtons("mood2", label = h4("Radio buttons"),
                           choices = c("like","share","angry","sad","haha","love","wow","sentiment"),
                           selected = "like"),
               checkboxInput("outlier", label = "去除極端值", value = FALSE)
             ),mainPanel(
               
               plotOutput("BoxPlot")
               
             )
             
           )
  ),

  #### Top ####
  tabPanel("Top文本",
           sidebarLayout(
             sidebarPanel(
               selectInput("Candi2", "Choose a dataset:",
                           choices = c("柯文哲", "丁守中", "姚文智"))
               ,numericInput('shows', '顯示項目', 5,
                             min = 1, max = 50),
               checkboxInput("decrease", label = "從大排到小", value = TRUE),
               radioButtons("mood3", label = h4("Radio buttons"),
                                                             choices = c("like","share","angry","sad","haha","love","wow","sentiment"),
                                                             selected = "like")
            
             ),mainPanel(
               
               h4("Observations"),
               tableOutput("TopText")
               
             )
             
             
             
             
           )
  ),
  
  #### 文字雲 ####
  tabPanel("四大報文字雲",
           sidebarLayout(
             sidebarPanel(
               selectInput("CandiXD", "北市候選人 :",
                           choices = list("柯文哲" = 1, "丁守中" = 2, "姚文智" = 3),
                           selected = 1),
               radioButtons("news", label = h3("媒體與社群"),
                           choices = list("自由" = 1, "聯合" = 2, "中時" = 3, "蘋果" = 4),
                           selected = 1),
               radioButtons("month", label = h3("月份"),
                           choices = list("2018" = 0, "Jan" = 1, "Feb" = 2, "Mar" = 3, "Apr" = 4, "May" = 5), 
                           selected = 0)
               
               
             ),
             mainPanel(
               
               h3("候選人文字雲"),
               plotOutput("CloudPlot", height = 700, width = 700)
               
             )
             
    
    
    
    
    
  )
           
  ),
  
  #### 文字雲 ####
  tabPanel("臉書文字雲",
           sidebarLayout(
             sidebarPanel(
               selectInput("candiXD", "北市候選人 :",
                           choices = list("柯文哲" = 1, "丁守中" = 2, "姚文智" = 3),
                           selected = 1),
               radioButtons("yue", label = h3("月份"),
                            choices = list("2018" = 0, "Jan" = 1, "Feb" = 2, "Mar" = 3, "Apr" = 4, "May" = 5, "Jun" = 6), 
                            selected = 0)
               
               
             ),
             mainPanel(
               
               h3("候選人粉專文字雲"),
               plotOutput("FaceCloudPlot", height = 600, width = 600)
               
             )
             
             
             
             
             
             
           )
           
  ),
  
  #### LDA ####
  tabPanel("LDA",
           h1("施工中!!")
  )
  
  
  
  
  
  )
)