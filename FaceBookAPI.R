library(jsonlite)
library(httr)
library(magrittr)

# Crawl data from facebookAPI
token = "EAACEdEose0cBAJAFfop9CXDM7djByDqTvPClh9aziKXpqYWegeaYMOocDRzTCfNs14CJDjpNwUR6MtBmn2AXkFk5moZALVnCTeZAk63iRXa74Cyvg7b3wa2QSEN1a0zuhaXBeSCFEocZA8mpMBZCM1YeIydy8GzuVPTZAPW6CB9Qd4h2kXjG2AnLnon6iwogZD"
FacebookID = "enc.teia"
url_1 = "https://graph.facebook.com/v2.12/"
url_2 = "?fields=posts%7Bcomments.limit(20)%7D&access_token="
url = paste0(url_1,FacebookID,url_2,token)
response = GET(url)
posts  = content(response)


data <- posts$posts$data

# 判斷是否有人留言

ismessage = sapply(posts$posts$data,function(x){
  if(length(x)==2) return (1)
  else return (0)
})

ismessageidx = NULL
for(i in c(1:length(ismessage))){
  if(ismessage[i]==1)
    ismessageidx <- c(ismessageidx,i)
}

ismessageidx
Output = data.frame()
for(i in ismessageidx){
  dataIn <- posts$posts$data[[i]]$comments$data %>% do.call(rbind,.) %>% data.frame()
  Output = rbind(Output,dataIn)
}
data1 <- posts$posts$data[[5]]$comments$data %>% do.call(rbind,.) %>% data.frame()
data2 <- posts$posts$data[[6]]$comments$data %>% do.call(rbind,.) %>% data.frame()
data3 <- posts$posts$data[[9]]$comments$data %>% do.call(rbind,.) %>% data.frame()
View(rbind(data1,data2,data3))

