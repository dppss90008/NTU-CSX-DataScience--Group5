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

##############################

# Crawl meassage data from facebookAPI
token = "EAACEdEose0cBAKpgRr3xJTS8ONSZA7xyZB0y2YX3PHPl7tJWrZAzPXuKqKZCxRE911bWb9L4nUSl25UUS5kjGlzz4ZBcau5CPVa5GqK48hFwbllsWhOtZCZAI1j0DZCpM3aAK4OcnDWzhnT62HQYUPkZBktIVEanTgPIzQlzBaVAPDZAIdEi8ng3XvRMkTouic8VsZD"
FacebookID = "enc.teia"
url_1 = "https://graph.facebook.com/v2.12/"
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

# Crawl Posts data from facebookAPI
url_1 = "https://graph.facebook.com/v3.0/"
url_2 = "?fields=posts.limit(25)&access_token="
url = paste0(url_1,FacebookID,url_2,token)
response = GET(url)
Posts  = content(response)

# Get posts/message from post <List>
Posts <- Posts$posts$data

# Get post create time
ismessageidx

Time <- c()
for(i in ismessageidx){
  Time <- c(Time,Posts[[i]]$created_time)
}
Time


##################################################################
# get shares from every post
url_1 = "https://graph.facebook.com/v3.0/"
url_2 = "?fields=posts.limit(25){shares}&access_token="
url = paste0(url_1,FacebookID,url_2,token)
response = GET(url)
shares  = content(response)
shares <- shares$posts$data
shares[[1]]$shares[[1]]

shareCT <- c()
for(i in c(1:25)){
  shareCT <- c(shareCT,shares[[i]]$shares[[1]])
}
shareCT



