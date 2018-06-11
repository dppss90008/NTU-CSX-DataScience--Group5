#搜尋頁面網址爬蟲
rm(list = ls())

library(httr)
library(rvest)

udn_head_url <- "https://udn.com/search/result/2/%E6%9F%AF%E6%96%87%E5%93%B2/"
url.link <- c()
for( i in 7:169) {
  url <- paste0(udn_head_url , i )
  url.link <- rbind(url.link , url )
}


#爬每一篇新聞的網址
links <- c()
for ( n in 1:length(url.link)) {
  print(n)
  doc <- read_html(url.link[n])
  css <- "#search_content > dt > a"
  node <- html_nodes(doc, css)
  link <- html_attrs(node) 
  links <- rbind(links, link)
  Sys.sleep(sample(1:5, 1))
}

#跑到151筆資料出現HTTP error 503

for ( r in 152:163) {
  print(r)
  doc <- read_html(url.link[r])
  css <- "#search_content > dt > a"
  node <- html_nodes(doc, css)
  link <- html_attrs(node) 
  links <- rbind(links, link)
  Sys.sleep(sample(1:5, 1))
}

news_links <- links[1:3240] 
news_links <- unlist(news_links)
news_links <- matrix(news_links , byrow = T , ncol = 2)
news_links <- news_links[ , 1 ] 

write.csv(news_links, file = "newspage_links")

#爬每一篇新聞的標題、時間、內文
#這邊要寫成function

title <- c()
time <- c()
text <- c()

for( i in c(1:length(news_links))){
  print(i)
  
  t.doc <-  read_html(news_links[i]) 
  title_node <- html_node(t.doc, "#story_art_title")
  t_title <- html_text(title_node)
  title <- rbind(title, t_title)
  
  time_node <- html_node(t.doc, "#story_bady_info > div > span")
  t_time <- html_text(time_node)
  time <- rbind(time, t_time)
  
  text_node <- html_nodes(t.doc, "#story_body_content > p")
  t_text <- html_text(text_node)
  bindtext <- ""
  for(i in c(1:length(t_text))){
    bindtext <- paste(bindtext,t_text[i])  
  }
  text <- rbind(text, bindtext)
  Sys.sleep(sample(1:10, 1))
  
}


#跑到1485
for( i in 1486:3240){
  print(i)
  
  t.doc <-  read_html(news_links[i]) 
  title_node <- html_node(t.doc, "#story_art_title")
  t_title <- html_text(title_node)
  title <- rbind(title, t_title)
  
  time_node <- html_node(t.doc, "#story_bady_info > div > span")
  t_time <- html_text(time_node)
  time <- rbind(time, t_time)
  
  text_node <- html_nodes(t.doc, "#story_body_content > p")
  t_text <- html_text(text_node)
  bindtext <- ""
  for(i in c(1:length(t_text))){
    bindtext <- paste(bindtext,t_text[i])  
  }
  text <- rbind(text, bindtext)
  Sys.sleep(sample(1:10, 1))
  
}

text <- text[1:2236]
time <- time[1:2236]
title <- title[1:2236]

for( i in 2238:3240){
  print(i)
  
  t.doc <-  read_html(news_links[i]) 
  title_node <- html_node(t.doc, "#story_art_title")
  t_title <- html_text(title_node)
  title <- rbind(title, t_title)
  
  time_node <- html_node(t.doc, "#story_bady_info > div > span")
  t_time <- html_text(time_node)
  time <- rbind(time, t_time)
  
  text_node <- html_nodes(t.doc, "#story_body_content > p")
  t_text <- html_text(text_node)
  bindtext <- ""
  for(i in c(1:length(t_text))){
    bindtext <- paste(bindtext,t_text[i])  
  }
  text <- rbind(text, bindtext)
  Sys.sleep(sample(1:10, 1))
  
}

udn_konews <- cbind(title, time, text)






# 2.將上述寫成function
# 3.跑所有連結

#存檔（爬到五月底）






# x <- c(1:length(links))
# 
# crawler_news <- function(x){
#   doc <- read_html(t.links[x])
#   title_node <- html_node(doc, "#story_art_title")
#   title <- html_text(title.node)
#   time_node <- html_node(doc, "#story_bady_info > div > span")
#   time <- html_text(time_node)
#   text_node <- html_nodes(doc, "#story_body_content > p")
#   text <- html_text(text.node)
#   
#   text <- ""
#   for( n in c(1:length(t_text))){
#     text <- paste(text,t_text[i])  
#   }
#   
#   return(title)
#   return(time)
#   return(text)
#  
# }
# 
# q <- crawler_news(1)