# rm(list = ls())
# 
# library(rvest)
# library(magrittr)
# library(httr)
# 
# # #爬姚文智五月的新聞
# #爬全部姚文智五月新聞搜尋頁面的連結
# url <- "https://tw.appledaily.com/search"
# Yao_MayApplinks <- c()
# 
# #爬全部連結的迴圈
# for(p in 1:29){
#   form <- list(searchType = "text",
#                keyword = "姚文智",
#                totalpage = "285",
#                page = sprintf("%d" , p ),
#                sorttype = "1",
#                rangedate = "[20180501 TO 20180531999:99]") 
#   res <- POST(url, body = form)
#   doc.str <- content(res, "text")
#   doc <- read_html(doc.str)
#   css <- "#result > li > div > h2 > a"
#   links <- html_attr(html_nodes(doc,css), "href")
#   Yao_MayApplinks <- c(Yao_MayApplinks, links)
#   message(p)
# }
# 
# #test是否抓到重複的網址
# test <- Yao_MayApplinks[?duplicated(Yao_MayApplinks)]
# 
# #爬五月連結的每一篇新聞
# #先寫可以爬每一篇新聞時間標題內文的function
# FindAppnews <- function(URL){
#   doc <- read_html(URL %>% as.character())
#   
#   title <- html_text(html_node(doc,  "#article > div.wrapper > div > main > article > hgroup > h1"))
#   time <- html_text(html_node(doc, "#article > div.wrapper > div > main > article > hgroup > div.ndArticle_creat"))
#   text <- html_text(html_node(doc, "#article > div.wrapper > div > main > article > div > div.ndArticle_contentBox > article > div > p"))
#   
#   output <- data.frame( title = title,
#                         text = text,
#                         time = time)
#   return(output)
# }
# 
# #爬姚文智五月的每一篇新聞的時間標題內文
# Yao_MayAppnews <- data.frame()
# for ( t in 1:length(Yao_MayApplinks)) {
#   print(t)
#   output1 <- FindAppnews(Yao_MayApplinks[t]) 
#   Yao_MayAppnews <- rbind(Yao_MayAppnews, output1)
#   Sys.sleep(sample(1:10, 1))
#   
# }
# 
# for ( t in 227:length(Yao_MayApplinks)) {
#   print(t)
#   output1 <- FindAppnews(Yao_MayApplinks[t]) 
#   Yao_MayAppnews <- rbind(Yao_MayAppnews, output1)
#   Sys.sleep(sample(1:10, 1))
#   
# }
# 
# 
# #存檔
# write.csv(Yao_MayAppnews, "Yao_MayAppnews")
# 
# # #爬姚文智四月的新聞
# #爬全部姚文智四月新聞搜尋頁面的連結
# url <- "https://tw.appledaily.com/search"
# Yao_AprApplinks <- c()
# 
# #爬全部連結的迴圈
# for(p in 1:11){
#   form <- list(searchType = "text",
#                keyword = "姚文智",
#                totalpage = "105",
#                page = sprintf("%d" , p ),
#                sorttype = "1",
#                rangedate = "[20180401 TO 20180430999:99]")
#   res <- POST(url, body = form)
#   doc.str <- content(res, "text")
#   doc <- read_html(doc.str)
#   css <- "#result > li > div > h2 > a"
#   links <- html_attr(html_nodes(doc,css), "href")
#   Yao_AprApplinks <- c(Yao_AprApplinks, links)
#   message(p)
# }
# 
# #test是否抓到重複的網址
# test <- Yao_AprApplinks[?duplicated(Yao_AprApplinks)]
# 
# #爬四月連結的每一篇新聞
# #爬姚文智四月的每一篇新聞的時間標題內文
# Yao_AprAppnews <- data.frame()
# for ( t in 1:length(Yao_AprApplinks)) {
#   print(t)
#   output2 <- FindAppnews(Yao_AprApplinks[t]) 
#   Yao_AprAppnews <- rbind(Yao_AprAppnews, output2)
#   Sys.sleep(sample(1:10, 1))
#   
# }
# 
# for ( t in 4:length(Yao_AprApplinks)) {
#   print(t)
#   output2 <- FindAppnews(Yao_AprApplinks[t]) 
#   Yao_AprAppnews <- rbind(Yao_AprAppnews, output2)
#   Sys.sleep(sample(1:10, 1))
#   
# }
# 
# #存檔
# write.csv(Yao_AprAppnews, "Yao_AprAppnews")
# 
# # #爬姚文智三月的新聞
# #爬全部姚文智三月新聞搜尋頁面的連結
# url <- "https://tw.appledaily.com/search"
# Yao_MarApplinks <- c()
# 
# #爬全部連結的迴圈
# for(p in 1:8){
#   form <- list(searchType = "text",
#                keyword = "姚文智",
#                totalpage = "78",
#                page = sprintf("%d" , p ),
#                sorttype = "1",
#                rangedate = "[20180301 TO 20180331999:99]")
#   res <- POST(url, body = form)
#   doc.str <- content(res, "text")
#   doc <- read_html(doc.str)
#   css <- "#result > li > div > h2 > a"
#   links <- html_attr(html_nodes(doc,css), "href")
#   Yao_MarApplinks <- c(Yao_MarApplinks, links)
#   message(p)
# }
# 
# #test是否抓到重複的網址
# test <- Yao_MarApplinks[?duplicated(Yao_MarApplinks)]
# 
# #爬三月連結的每一篇新聞
# #爬姚文智三月的每一篇新聞的時間標題內文
# Yao_MarAppnews <- data.frame()
# for ( t in 1:length(Yao_MarApplinks)) {
#   print(t)
#   output3 <- FindAppnews(Yao_MarApplinks[t]) 
#   Yao_MarAppnews <- rbind(Yao_MarAppnews, output3)
#   Sys.sleep(sample(1:10, 1))
#   
# }
# 
# #存檔
# write.csv(Yao_MarAppnews, "Yao_MarAppnews")
# 
# # #爬姚文智二月的新聞
# #爬全部姚文智二月新聞搜尋頁面的連結
# url <- "https://tw.appledaily.com/search"
# Yao_FebApplinks <- c()
# 
# #爬全部連結的迴圈
# for(p in 1:8){
#   form <- list(searchType = "text",
#                keyword = "姚文智",
#                totalpage = "77",
#                page = sprintf("%d" , p ),
#                sorttype = "1",
#                rangedate = "[20180201 TO 20180228999:99]")
#   res <- POST(url, body = form)
#   doc.str <- content(res, "text")
#   doc <- read_html(doc.str)
#   css <- "#result > li > div > h2 > a"
#   links <- html_attr(html_nodes(doc,css), "href")
#   Yao_FebApplinks <- c(Yao_FebApplinks, links)
#   message(p)
# }
# 
# #test是否抓到重複的網址
# test <- Yao_FebApplinks[?duplicated(Yao_FebApplinks)]
# 
# #爬二月連結的每一篇新聞
# #爬姚文智二月的每一篇新聞的時間標題內文
# Yao_FebAppnews <- data.frame()
# for ( t in 1:length(Yao_FebApplinks)) {
#   print(t)
#   output4 <- FindAppnews(Yao_FebApplinks[t]) 
#   Yao_FebAppnews <- rbind(Yao_FebAppnews, output4)
#   Sys.sleep(sample(1:10, 1))
#   
# }
# 
# #存檔
# write.csv(Yao_FebAppnews, "Yao_FebAppnews")
# 
# # #爬姚文智一月的新聞
# #爬全部姚文智一月新聞搜尋頁面的連結
# url <- "https://tw.appledaily.com/search"
# Yao_JanApplinks <- c()
# 
# #爬全部連結的迴圈
# for(p in 1:5){
#   form <- list(searchType = "text",
#                keyword = "姚文智",
#                totalpage = "41",
#                page = sprintf("%d" , p ),
#                sorttype = "1",
#                rangedate = "[20180101 TO 20180131999:99]")
#   res <- POST(url, body = form)
#   doc.str <- content(res, "text")
#   doc <- read_html(doc.str)
#   css <- "#result > li > div > h2 > a"
#   links <- html_attr(html_nodes(doc,css), "href")
#   Yao_JanApplinks <- c(Yao_JanApplinks, links)
#   message(p)
# }
# 
# #test是否抓到重複的網址
# test <- Yao_JanApplinks[?duplicated(Yao_JanApplinks)]
# 
# #爬一月連結的每一篇新聞
# #爬姚文智一月的每一篇新聞的時間標題內文
# Yao_JanAppnews <- data.frame()
# for ( t in 1:length(Yao_JanApplinks)) {
#   print(t)
#   output4 <- FindAppnews(Yao_JanApplinks[t]) 
#   YaoJanAppnews <- rbind(Yao_JanAppnews, output4)
#   Sys.sleep(sample(1:10, 1))
#   
# }
# 
# #存檔
# write.csv(Yao_JanAppnews, "Yao_JanAppnews")
# 
# 
# library(rvest)
# library(magrittr)
# 
# Yao_MayAppnews <- read.csv("Yao_MayAppnews")
# Yao_AprAppnews <- read.csv("Yao_AprAppnews")
# Yao_MarAppnews <- read.csv("Yao_MarAppnews")
# Yao_FebAppnews <- read.csv("Yao_FebAppnews")
# #Yao_JanAppnews <- read.csv("Yao_JanAppnews") ＱＱ要重爬
# 
# Yao_Appnews <- rbind(Yao_MayAppnews, Yao_AprAppnews, Yao_MarAppnews, Yao_FebAppnews)
# sum(is.na(Yao_Appnews$text)) #QQ
# 
# #去掉含有NA值的欄位QQ
# Yao_Appnews <- Yao_Appnews %>% na.omit()
# 
# #用strsplit將 報導） 後面的雜訊清掉
# cleancontent <- c()
# for( i in 1:length(Yao_Appnews$text)){
#   t <- strsplit(Yao_Appnews$text[i] %>% as.character() , "報導）")
#   t <- t[[1]][1]
#   cleancontent <- rbind(cleancontent, t)
#   print(i)
# }
# 
# cleancontent <- data.frame(cleancontent)
# 
# library(tibble)
# library(dplyr)
# library(tidyr)
# library(data.table)
# #切割時間
# Yao_Appnews <- Yao_Appnews %>% separate(time, c("出版時間","ttime"),"：") 
# #將text的欄位切成出版時間和time兩欄欄
# Yao_Appnews <- Yao_Appnews %>% separate(ttime, c("ttime","stime")," ") 
# Yao_Appnews <- Yao_Appnews %>% separate(ttime, c("year","month", "day"),"/") 
# Yao_Appnews <- cbind(Yao_Appnews$title, Yao_Appnews$year, Yao_Appnews$month, Yao_Appnews$day, cleancontent)
# 
# colnames(Yao_Appnews) <- c("title", "year", "month", "day", "content")
# 
# #增加Media的欄位
# Media <- c()
# text <- c("Apple")
# for( i in 1:length(Yao_Appnews$content)){
#   Media <- rbind(Media, text)
# }
# 
# Yao_Appnews <- cbind(Media, Yao_Appnews)
# 
# write.csv(Yao_Appnews, "Yao_Appnews")

#Bind上其他媒體的新聞
#打開蘋果、中時的姚新聞
Yao_Appnews <- read.csv("Yao_Appnews")
Yao_CTnews <- read.csv("../CTnews/Yao_CTnews")

#幫中時的媒體欄位改名
#增加Media的欄位
Media <- c()
text <- c("CT")
for( i in 1:length(Yao_CTnews$content)){
   Media <- rbind(Media, text)
 }

#將中時的媒體欄位值換成另一欄
Yao_CTnews$Media <- Media

library(magrittr)
Yao_CTnews <- Yao_CTnews[ , 2:7] %>% data.frame()
Yao_Appnews <- Yao_Appnews[, 2:7] %>% data.frame()

rownames(Yao_CTnews) <- c()
rownames(Yao_Appnews) <- c()


#bind中時和蘋果的新聞
#用rbind會出現 Error in rownames(value[[jj]])[ri] <- rownames(xij) : 置換的長度為零
#不知如何解決，所以用了dplyr的bind_rows
library(dplyr)
Yao_news <- bind_rows(Yao_CTnews, Yao_Appnews)

#存檔
write.csv(Yao_news,"Yao_news")



