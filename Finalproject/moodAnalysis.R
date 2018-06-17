library(stringr)
library(jiebaR)





pos<-read.csv('NTUSD_positive_UTF-8.csv',header=F,stringsAsFactors=FALSE,encoding = "unicode")
weight <- rep(1, length(pos[,1])) #正面情感词语赋权重为1
pos <- cbind(pos, weight)
neg<-read.csv('NTUSD_negative_UTF-8.csv',header=F,stringsAsFactors=FALSE,encoding = "unicode")
weight <- rep(-1, length(neg[,1])) #负面情感词语赋权重为-1
neg <- cbind(neg, weight)
posneg<-rbind(pos,neg)
colnames(posneg)<-c('term','weight')

user<-posneg[,'term']

Data <- read.csv("Di_JanFebNews.csv")
text <- Data$V3[1]
text
w1<-worker()
new_user_word(w1,user)


# 文字清理
library(NLP)
library(tm)
library(jiebaRD)
library(jiebaR)

docs <- Corpus(VectorSource(Data$V3))
toSpace <- content_transformer(function(x,pattern){
  return(gsub(pattern," ",x))
})

docs <- tm_map(docs,toSpace,"\n")
docs <- tm_map(docs,toSpace, "[A-Za-z0-9]")
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, toSpace, "、")
docs <- tm_map(docs, toSpace, "，")
docs <- tm_map(docs, toSpace, "。")
docs <- tm_map(docs, toSpace, "！")
docs <- tm_map(docs, toSpace, "「")
docs <- tm_map(docs, toSpace, "（")
docs <- tm_map(docs, toSpace, "」")
docs <- tm_map(docs, toSpace, "）")
docs <- tm_map(docs, toSpace, "\n")
docs <- tm_map(docs, toSpace, "；")
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, toSpace, "[a-zA-Z]")
docs <- tm_map(docs, stripWhitespace)

text <- docs[[1]]$content
text<-list(text)
res<-segment(unlist(text),w1)
res
temp<-data.frame()
temp[c(1:length(res)),1]<-rep('1.text' ,length(res)) #id
temp[c(1:length(res)),2]<-res[1:length(res)]#term
colnames(temp)<-c('id','term')

library(plyr)
temp<-join(temp,posneg,by='term')
temp<-temp[!is.na(temp$weight),]
head(temp)
#计算情感指数
senti<-sum(temp$weight)
senti
Ct_pos <- temp[temp$weight==1,3] %>% length()
Ct_neg <- temp[temp$weight==-1,3] %>% length()

Ct_pos/(Ct_pos+Ct_neg)



