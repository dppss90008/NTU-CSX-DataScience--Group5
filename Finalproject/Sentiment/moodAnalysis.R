library(jiebaRD)
library(jiebaR)

#### 使用情感字典 <NTUSD> ####
pos<-read.csv('NTUSD_positive_unicode.csv',header=F,stringsAsFactors=FALSE,encoding = "unicode")
weight <- rep(1, length(pos[,1])) #正面情感詞語權重為1
pos <- cbind(pos, weight)
neg<-read.csv('NTUSD_negative_unicode.csv',header=F,stringsAsFactors=FALSE,encoding = "unicode")
weight <- rep(-1, length(neg[,1])) #負面情感詞語權重為-1
neg <- cbind(neg, weight)
posneg<-rbind(pos,neg)
colnames(posneg)<-c('term','weight')
# 關閉pos、neg及weight
rm(pos)
rm(neg)
rm(weight)

# 建立切分詞字典<NTUSD加入字典>及環境
user<-posneg[,'term']
w1<-worker()
new_user_word(w1,user)


#### 文字清理 ####

# 使用測試資料
Data <- read.csv("FB_result/Di_report.csv")
Data <- Data[-64,]
# 清除去年資照片


# 套件引用
library(NLP)
library(stringr)
library(tm)
library(plyr)

# 文字清理
docs <- Corpus(VectorSource(Data$post))
toSpace <- content_transformer(function(x,pattern){
  return(gsub(pattern," ",x))
})

clean_doc <- function(docs){
  clean_words <- c("[A-Za-z0-9]","、","《","『","』","【","】","／","，","。","！","「","（","」","）","\n","；")
  for(i in 1:length(clean_words)){
    docs <- tm_map(docs,toSpace, clean_words[i])
  }
  return(docs)
}

docs <- clean_doc(docs)


# 開始切詞

jieba_tokenizer = function(d){
  unlist(segment(d[[1]], w1))
}



seg = lapply(docs, jieba_tokenizer)

# 計算情感分數
sentiment_point <- sapply(seg,function(d){
  res <- d
  temp<-data.frame()
  temp[c(1:length(res)),1]<-rep('1.text' ,length(res)) #id
  temp[c(1:length(res)),2]<-res[1:length(res)]#term
  colnames(temp)<-c('id','term')
  temp<-join(temp,posneg,by='term')
  temp<-temp[!is.na(temp$weight),]
  Ct_pos <- temp[temp$weight==1,3] %>% length()
  Ct_neg <- temp[temp$weight==-1,3] %>% length()
  return(Ct_pos/(Ct_pos+Ct_neg))
})

# 將NA改成0.5
sentiment_point[sentiment_point %>% is.na] = 0.5
Data <- cbind(Data,sentiment_point)

# 加上name
name <- rep("Di", length(Data[,1]))
Data <- cbind(name,Data)


write.csv(Data,"Di_result_sentiment.csv")

Di_data <- read.csv("Di_result_sentiment.csv")
Di_data <- Di_data[-c(267:300),]
write.csv(Di_data,file="Di_result_sentiment2.csv")
Ko_data <- read.csv("Ko_result_sentiment.csv")
Ko_data <- Ko_data[-c(138:200),]
write.csv(Ko_data,file="Ko_result_sentiment2.csv")
Yao_data <- read.csv("Yao_result_sentiment.csv")
Yao_data <- Yao_data[-c(247:290),]
write.csv(Yao_data,file="Yao_result_sentiment2.csv")

FacebookAPI_res <- rbind(Ko_data,Yao_data,Di_data)
FacebookAPI_res$name <- FacebookAPI_res$name %>% as.factor()
FacebookAPI_res$time <- FacebookAPI_res$time %>% as.Date()
write.csv(FacebookAPI_res,"FacebookAPI_res.csv")

# 畫折線圖
library(ggplot2)

# 三人分別likes累計圖
Yao_like_time <- qplot(time%>% as.Date(),like, data = Yao_data,geom = c("point", "smooth"),xlab = "time",main = "姚文智 Facebook likes 累計圖 (一月到六月)")
Ko_like_time <- qplot(time%>% as.Date(),like, data = Ko_data,geom = c("point", "smooth"),xlab = "time",main = "柯文哲 Facebook likes 累計圖 (一月到六月)")
Di_like_time <- qplot(time%>% as.Date(),like, data = Di_data,geom = c("point", "smooth"),xlab = "time",main = "丁守中 Facebook likes 累計圖 (一月到六月)")

# box plot like 三人比較
box_like <- qplot(name,like, data = FacebookAPI_res, geom = c("boxplot"),main="台北市候選人likes數box plot")

# box plot sentiment 文章風格
qplot(name,sentiment_point, data = FacebookAPI_res, geom = c("boxplot"))

# 三人分別angry 累計圖
Yao_angry_time <- qplot(time%>% as.Date(),angry, data = Yao_data,geom = c("point", "smooth"),xlab = "time",main = "姚文智 Facebook angry 累計圖 (一月到六月)")
Ko_angry_time <- qplot(time%>% as.Date(),angry, data = Ko_data,geom = c("point", "smooth"),xlab = "time",main = "柯文哲 Facebook angry 累計圖 (一月到六月)")
Di_angry_time <- qplot(time%>% as.Date(),angry, data = Di_data,geom = c("point", "smooth"),xlab = "time",main = "丁守中 Facebook angry 累計圖 (一月到六月)")

# box plot like 三人比較
box_angry <- qplot(name,angry, data = FacebookAPI_res, geom = c("boxplot"),main="台北市候選人angry數box plot")



# 三人分別share 累計圖
Yao_share_time <- qplot(time%>% as.Date(),share, data = Yao_data,geom = c("point", "smooth"),xlab = "time",main = "姚文智 Facebook share 累計圖 (一月到六月)")
Ko_share_time <- qplot(time%>% as.Date(),share, data = Ko_data,geom = c("point", "smooth"),xlab = "time",main = "柯文哲 Facebook share 累計圖 (一月到六月)")
Di_share_time <- qplot(time%>% as.Date(),share, data = Di_data,geom = c("point", "smooth"),xlab = "time",main = "丁守中 Facebook share 累計圖 (一月到六月)")

# box plot like 三人比較
box_share <- qplot(name,share, data = FacebookAPI_res, geom = c("boxplot"),main="台北市候選人share數box plot")
