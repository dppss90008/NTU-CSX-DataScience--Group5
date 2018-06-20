library(shiny)


shinyUI(navbarPage("選戰懶人包",

                   navbarMenu("FaceBook",
                              tabPanel("趨勢圖",sidebarLayout(
                                
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
                              tabPanel("盒狀圖",sidebarLayout(
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
                                         
                                         
                                         
                                         
                                       )),
                              tabPanel("文字雲"),
                              tabPanel("LDA",sidebarLayout(
                                sidebarPanel(
                                  selectInput("PostCandi", "Choose a dataset:",
                                              choices = c("柯文哲", "丁守中", "姚文智"))
                                  
                                ),mainPanel(
                                  
                                  h4("Observations"),
                                  plotOutput("postLDA",height = 600, width = 1200)
                                  
                                )
                              )
                                       
                                       
                                       
                                       
                                       
                                       )
                              ),
    
                  navbarMenu("四大報",
                              tabPanel("情緒分析<以候選人分類>",
                                       sidebarLayout(
                                         sidebarPanel(
                                           selectInput("newsCandi", "Choose a dataset:",
                                                       choices = c("柯文哲", "丁守中", "姚文智"))
                                           
                                         ),mainPanel(
                                           
                                           h4("Observations"),
                                           plotOutput("NewsMood")
                                           
                                         )
                                       )
                                       
                                       
                                       
                                       ),
                             
                             tabPanel("情緒分析<以報紙分類>",
                                      sidebarLayout(
                                        sidebarPanel(
                                          selectInput("newsName", "Choose a dataset:",
                                                      choices = c("UDN", "CT", "LTN","Apple"))
                                          
                                        ),mainPanel(
                                          
                                          h4("Observations"),
                                          plotOutput("NewsMood2")
                                          
                                        )
                                      )
                                      
                                      
                                      
                             ),
                              tabPanel("文字雲"),
                              tabPanel("LDA" ,
                                       
                                       sidebarLayout(
                                          sidebarPanel(
                                            selectInput("newsLDA", "Choose a dataset:",
                                              choices = c("UDN", "CT", "LTN","Apple")),
                                            selectInput("nameLDA", "Choose a dataset:",
                                              choices = c("柯文哲", "丁守中", "姚文智"))
                                  
                                        ),mainPanel(
                                  
                                              h4("Observations"),
                                              plotOutput("newsLDA",height = 600, width = 1200)
                                  
                                )
                              ))),
                  
                  tabPanel("討論")

  )
)