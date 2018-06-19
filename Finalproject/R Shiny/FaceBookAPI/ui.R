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
                            choices = list("like" = "like", "share" = "share", "angry" = "angry"), 
                            selected = "like")
               
             ), mainPanel(
               
               plotOutput("TrendPlot")
               
             )
           
           )       
    ),
  
  
  #### 盒狀圖布局 ####
  tabPanel("盒狀圖",
           h1("Hi, this is an example page")
  ),
  
  #### Top ####
  tabPanel("Top文本",
           h1("Hi, this is an example page")
  ),
  
  #### 文字雲 ####
  tabPanel("文字雲",
           h1("Hi, this is an example page")
  ),
  
  #### LDA ####
  tabPanel("LDA",
           h1("Hi, this is an example page")
  )
  
  
  
  
 )
)
