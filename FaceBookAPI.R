# 引用套件
library(jsonlite)
library(httr)
library(magrittr)

####六都候選人臉書粉絲專頁####

##台北市##
#柯文哲https://www.facebook.com/DoctorKoWJ/
#姚文智https://www.facebook.com/YaoTurningTaipei/
#丁守中https://www.facebook.com/tingshouchung/

##新北市##

##台中市##

##測試使用##
#enc.teia

##########FacebookAPI#########

token = "EAACEdEose0cBAKrtaNzZBBdVMHTMr5jvNp1iRtJZCfEXEpLCZAGI9KmA8ZBvAmzn7Oy4sF9f0x4nMw9pyKn07fmaKQU2v8ioO4y7YnS7Q5yBPTwvZCxJIu68SFRCw3113lZAU2WhVSFzZBHslY83w94AXSOy8VXZBZCZBgM9LOuCi6ZChXnwE5i8rb2pJqkYltXhW4ZD"
FacebookID = "DoctorKoWJ"

##############################
# 暫時中止開發

# Crawl meassage data from facebookAPI(every post)

url_1 = "https://graph.facebook.com/v3.0/"
url_2 = "?fields=posts%7Bcomments.limit(20)%7D&access_token="
url = paste0(url_1,FacebookID,url_2,token)
response = GET(url)
message  = content(response)

# Get message from post <List>
message <- message$posts$data
  
# find if there is empty post(no messafe return 0)
ismessage = sapply(message,function(x){
  if(length(x)==2) return (1)
  else return (0)
})

ismessage

# Get post idx(have message)
ismessageidx = NULL
for(i in c(1:length(ismessage))){
  if(ismessage[i]==1)
    ismessageidx <- c(ismessageidx,i)
}

ismessageidx

## create dataframe with same col number
## there is a from in posts$posts$data[[2]]$comments$data[[1]]$from


findMesNum <- function(i){
  message[[i]]$comments$data %>% length %>% return()
}
findMes2Num <- function(x,y){
  message[[x]]$comments$data[[y]] %>% length %>% return()
}

for(i in ismessageidx){
  for(j in c(1:findMesNum(i))){
    if(findMes2Num(i,j)==4){
      message[[i]]$comments$data[[j]]$from <- NULL
    }
  }
}

Output <- data.frame()
for(i in ismessageidx){
  data <- message[[i]]$comments$data %>% do.call(rbind,.)%>% data.frame()
  data <- cbind(i,data)
  Output <- rbind(Output,data)  
}

##########################################################################
## Crawl posts data <posts內容、分享、按讚>

# Crawl Posts data from facebookAPI 已完成開發
url_1 = "https://graph.facebook.com/v3.0/"
url_2 = "?fields=posts.limit(200)&access_token="
url = paste0(url_1,FacebookID,url_2,token)
response = GET(url)
Posts  = content(response)

# Get posts/message from post <List>
Posts <- Posts$posts$data

# Get post data in data.frame -> post_data
post_data <- data.frame()
post_data<- sapply(Posts,function(data){
  return(cbind(data$created_time,data$message))
}) %>% t

##################################################################
# get shares from every post 已完成開發

url_1 = "https://graph.facebook.com/v3.0/"
url_2 = "?fields=posts.limit(200){shares}&access_token="
url = paste0(url_1,FacebookID,url_2,token)
response = GET(url)
shares  = content(response)
shares <- shares$posts$data

shareCT <- c()
for(i in c(1:200)){
  shareCT <- c(shareCT,shares[[i]]$shares[[1]])
}
shareCT

# 整合到post_data
post_data <- cbind(post_data,shareCT)
###################################################################

# get 讚!!
url_1 = "https://graph.facebook.com/v3.0/"
url_2 = "?fields=posts.limit(200){shares}&access_token="


url = "https://graph.facebook.com/{136845026417486_1311790355589608}/reactions?summary=total_count&access_token={EAACEdEose0cBAL4jqM4tJmAICtV93Mk756ZC3d1BGWgznA6Wsn6aAwAwQzRuHbOdO4IvRgJM5GUnHWXkBuFxrp9R9bJOnTT1gCCLFFfy4ErQykjUaZBHDhn3BzcaLMVo3U0fv1SChzImGrWtSYx1fy9mGArChx4NY9k5ONMvIV1svlojSaZBPlRGvp6wJMZD}"
