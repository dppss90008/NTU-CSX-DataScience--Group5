# ===== 文字雲程式
# ===== 處理柯文哲1月至5月的文章
# ------------------------------------------
# 遇到問題#1 : 
# 每篇首尾都是規律的廢話，不過有少部分沒有廢話，所以無法用substr()一次清乾淨
# 解決方法#1 :
# 用toSpace函數與tm_map功能換掉廢話，不過又衍生新的問題(已解決)


# 匯入套件
library(dplyr)
library(NLP)
library(tm)
library(jiebaRD)
library(jiebaR)
library(magrittr)
library(RColorBrewer)
library(wordcloud)

# 匯入資料組
setwd("/Users/Weber/Documents/GitHub/NTU-CSX-DataScience--Group5/Finalproject/LTN/Ko")
data_1 <- read.csv("Ko_JanLtnNews", encoding = "big5")
data_2 <- read.csv("Ko_FebLtnNews", encoding = "big5")
data_3 <- read.csv("Ko_MarLtnNews", encoding = "big5")
data_4 <- read.csv("Ko_AprLtnNews", encoding = "big5")
data_5 <- read.csv("Ko_MayLtnNews", encoding = "big5")

# Di_text <- matrix(data = NA, nrow = 67,ncol = 5 )
# Di_text <- cbind(data_1$bindtext, data_2$bindtext, data_3$bindtext, data_4$bindtext, data_5$bindtext)

# ----------------------------------------------------------------------------------------------------------
# 清理文本內容，刪除文本中不需要的雜訊
# data_i$bindtext <- substr(data$bindtext, 69, (nchar(as.vector(data$bindtext))-183))
# data$bindtext <- substr(data$bindtext, 69, (nchar(as.vector(data$bindtext))-183))
# 切詞
# data_1$bindtext[1:3] <- substr(data_1$bindtext[1:3], 69, (nchar(as.vector(data_1$bindtext[1:3]))-176))
# ----------------------------------------------------------------------------------------------------------
# 以上內容有待開發


#====== 1月切詞
docs <- Corpus(VectorSource(data_1$bindtext))
toSpace <- content_transformer(function(x,pattern){
  return(gsub(pattern," ",x))
})
# 刪去單詞贅字、英文字母、標點符號、數字與空格
docs <- tm_map(docs, toSpace, " 為達最佳瀏覽效果，建議使用 Chrome、Firefox 或 Internet Explorer 10")
docs <- tm_map(docs, toSpace, "新聞送上來！快加入自由電子報APP、LINE好友  2018年6月13日‧星期三‧戊戌年四月卅 注目新聞 1 中國卡車罷工延燒 司機高喊「打倒共產黨」！ 2 新版身分證票選出爐 設計師魯少綸奪首獎！ 3 洋腸又來！夜店外帶18歲妹 網站取名「台女很容易」... 4 侯友宜妻1塊土地99個門牌 蘇貞昌：太荒唐 5 連俞涵超正弟媳曝光…根本巨乳林志玲！")
docs <- tm_map(docs, toSpace, "以上版本的瀏覽器。 爆")
docs <- tm_map(docs,toSpace,"\n")
docs <- tm_map(docs,toSpace, "[A-Za-z0-9]")
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
docs <- tm_map(docs, toSpace, "的")
docs <- tm_map(docs, toSpace, "也")
docs <- tm_map(docs, toSpace, "都")
docs <- tm_map(docs, toSpace, "就")
docs <- tm_map(docs, toSpace, "與")
docs <- tm_map(docs, toSpace, "但")
docs <- tm_map(docs, toSpace, "是")
docs <- tm_map(docs, toSpace, "在")
docs <- tm_map(docs, toSpace, "和")
docs <- tm_map(docs, toSpace, "及")
docs <- tm_map(docs, toSpace, "為")
docs <- tm_map(docs, toSpace, "或")
docs <- tm_map(docs, toSpace, "且")
docs <- tm_map(docs, toSpace, "有")
docs <- tm_map(docs, toSpace, "含")
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, toSpace, "[a-zA-Z]")
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, removePunctuation)
# 匯入自定義字典
mixseg = worker()
segment <- c("柯文哲","姚文智","丁守中","台北市長","選舉","候選人","台灣","選票","柯市長","民進黨","國民黨","台北市民","市民")
new_user_word(mixseg,segment)

#有詞頻之後就可以去畫文字雲
jieba_tokenizer=function(d){
  unlist(segment(d[[1]],mixseg))
}
seg = lapply(docs, jieba_tokenizer)
freqFrame = as.data.frame(table(unlist(seg)))
# 畫出文字雲
# 儲存文字雲圖片
png("Ko_Jan.png", width = 500, height = 500 )

wordcloud(freqFrame$Var1,freqFrame$Freq,
          min.freq=70,
          random.order=TRUE,random.color=TRUE, 
          rot.per=.1, colors=rainbow(length(row.names(freqFrame))),
          ordered.colors=FALSE,use.r.layout=FALSE,
          fixed.asp=TRUE)
dev.off()


#====== 2月切詞
docs <- Corpus(VectorSource(data_2$bindtext))
toSpace <- content_transformer(function(x,pattern){
  return(gsub(pattern," ",x))
})
# 刪去單詞贅字、英文字母、標點符號、數字與空格
docs <- tm_map(docs, toSpace, " 為達最佳瀏覽效果，建議使用 Chrome、Firefox 或 Internet Explorer 10")
docs <- tm_map(docs, toSpace, "新聞送上來！快加入自由電子報APP、LINE好友  2018年6月13日‧星期三‧戊戌年四月卅 注目新聞 1 中國卡車罷工延燒 司機高喊「打倒共產黨」！ 2 新版身分證票選出爐 設計師魯少綸奪首獎！ 3 洋腸又來！夜店外帶18歲妹 網站取名「台女很容易」... 4 侯友宜妻1塊土地99個門牌 蘇貞昌：太荒唐 5 連俞涵超正弟媳曝光…根本巨乳林志玲！")
docs <- tm_map(docs, toSpace, "以上版本的瀏覽器。 爆")
docs <- tm_map(docs,toSpace,"\n")
docs <- tm_map(docs,toSpace, "[A-Za-z0-9]")
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
docs <- tm_map(docs, toSpace, "的")
docs <- tm_map(docs, toSpace, "也")
docs <- tm_map(docs, toSpace, "都")
docs <- tm_map(docs, toSpace, "就")
docs <- tm_map(docs, toSpace, "與")
docs <- tm_map(docs, toSpace, "但")
docs <- tm_map(docs, toSpace, "是")
docs <- tm_map(docs, toSpace, "在")
docs <- tm_map(docs, toSpace, "和")
docs <- tm_map(docs, toSpace, "及")
docs <- tm_map(docs, toSpace, "為")
docs <- tm_map(docs, toSpace, "或")
docs <- tm_map(docs, toSpace, "且")
docs <- tm_map(docs, toSpace, "有")
docs <- tm_map(docs, toSpace, "含")
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, toSpace, "[a-zA-Z]")
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, removePunctuation)
# 匯入自定義字典
mixseg = worker()
segment <- c("柯文哲","姚文智","丁守中","台北市長","選舉","候選人","台灣","選票","柯市長","民進黨","國民黨","台北市民","市民")
new_user_word(mixseg,segment)

#有詞頻之後就可以去畫文字雲
jieba_tokenizer=function(d){
  unlist(segment(d[[1]],mixseg))
}
seg = lapply(docs, jieba_tokenizer)
freqFrame = as.data.frame(table(unlist(seg)))
# 畫出文字雲
# 儲存文字雲圖片
png("Ko_Feb.png", width = 500, height = 500 )

wordcloud(freqFrame$Var1,freqFrame$Freq,
          min.freq=70,
          random.order=TRUE,random.color=TRUE, 
          rot.per=.1, colors=rainbow(length(row.names(freqFrame))),
          ordered.colors=FALSE,use.r.layout=FALSE,
          fixed.asp=TRUE)
dev.off()

#====== 3月切詞
docs <- Corpus(VectorSource(data_3$bindtext))
toSpace <- content_transformer(function(x,pattern){
  return(gsub(pattern," ",x))
})
# 刪去單詞贅字、英文字母、標點符號、數字與空格
docs <- tm_map(docs, toSpace, " 為達最佳瀏覽效果，建議使用 Chrome、Firefox 或 Internet Explorer 10")
docs <- tm_map(docs, toSpace, "新聞送上來！快加入自由電子報APP、LINE好友  2018年6月13日‧星期三‧戊戌年四月卅 注目新聞 1 中國卡車罷工延燒 司機高喊「打倒共產黨」！ 2 新版身分證票選出爐 設計師魯少綸奪首獎！ 3 洋腸又來！夜店外帶18歲妹 網站取名「台女很容易」... 4 侯友宜妻1塊土地99個門牌 蘇貞昌：太荒唐 5 連俞涵超正弟媳曝光…根本巨乳林志玲！")
docs <- tm_map(docs, toSpace, "以上版本的瀏覽器。 爆")
docs <- tm_map(docs,toSpace,"\n")
docs <- tm_map(docs,toSpace, "[A-Za-z0-9]")
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
docs <- tm_map(docs, toSpace, "的")
docs <- tm_map(docs, toSpace, "也")
docs <- tm_map(docs, toSpace, "都")
docs <- tm_map(docs, toSpace, "就")
docs <- tm_map(docs, toSpace, "與")
docs <- tm_map(docs, toSpace, "但")
docs <- tm_map(docs, toSpace, "是")
docs <- tm_map(docs, toSpace, "在")
docs <- tm_map(docs, toSpace, "和")
docs <- tm_map(docs, toSpace, "及")
docs <- tm_map(docs, toSpace, "為")
docs <- tm_map(docs, toSpace, "或")
docs <- tm_map(docs, toSpace, "且")
docs <- tm_map(docs, toSpace, "有")
docs <- tm_map(docs, toSpace, "含")
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, toSpace, "[a-zA-Z]")
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, removePunctuation)
# 匯入自定義字典
mixseg = worker()
segment <- c("柯文哲","姚文智","丁守中","台北市長","選舉","候選人","台灣","選票","柯市長","民進黨","國民黨","台北市民","市民")
new_user_word(mixseg,segment)

#有詞頻之後就可以去畫文字雲
jieba_tokenizer=function(d){
  unlist(segment(d[[1]],mixseg))
}
seg = lapply(docs, jieba_tokenizer)
freqFrame = as.data.frame(table(unlist(seg)))
# 畫出文字雲
# 儲存文字雲圖片
png("Ko_Mar.png", width = 500, height = 500 )

wordcloud(freqFrame$Var1,freqFrame$Freq,
          min.freq=70,
          random.order=TRUE,random.color=TRUE, 
          rot.per=.1, colors=rainbow(length(row.names(freqFrame))),
          ordered.colors=FALSE,use.r.layout=FALSE,
          fixed.asp=TRUE)
dev.off()

#====== 4月切詞
docs <- Corpus(VectorSource(data_4$bindtext))
toSpace <- content_transformer(function(x,pattern){
  return(gsub(pattern," ",x))
})
# 刪去單詞贅字、英文字母、標點符號、數字與空格
docs <- tm_map(docs, toSpace, " 為達最佳瀏覽效果，建議使用 Chrome、Firefox 或 Internet Explorer 10")
docs <- tm_map(docs, toSpace, "新聞送上來！快加入自由電子報APP、LINE好友  2018年6月13日‧星期三‧戊戌年四月卅 注目新聞 1 中國卡車罷工延燒 司機高喊「打倒共產黨」！ 2 新版身分證票選出爐 設計師魯少綸奪首獎！ 3 洋腸又來！夜店外帶18歲妹 網站取名「台女很容易」... 4 侯友宜妻1塊土地99個門牌 蘇貞昌：太荒唐 5 連俞涵超正弟媳曝光…根本巨乳林志玲！")
docs <- tm_map(docs, toSpace, "以上版本的瀏覽器。 爆")
docs <- tm_map(docs,toSpace,"\n")
docs <- tm_map(docs,toSpace, "[A-Za-z0-9]")
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
docs <- tm_map(docs, toSpace, "的")
docs <- tm_map(docs, toSpace, "也")
docs <- tm_map(docs, toSpace, "都")
docs <- tm_map(docs, toSpace, "就")
docs <- tm_map(docs, toSpace, "與")
docs <- tm_map(docs, toSpace, "但")
docs <- tm_map(docs, toSpace, "是")
docs <- tm_map(docs, toSpace, "在")
docs <- tm_map(docs, toSpace, "和")
docs <- tm_map(docs, toSpace, "及")
docs <- tm_map(docs, toSpace, "為")
docs <- tm_map(docs, toSpace, "或")
docs <- tm_map(docs, toSpace, "且")
docs <- tm_map(docs, toSpace, "有")
docs <- tm_map(docs, toSpace, "含")
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, toSpace, "[a-zA-Z]")
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, removePunctuation)
# 匯入自定義字典
mixseg = worker()
segment <- c("柯文哲","姚文智","丁守中","台北市長","選舉","候選人","台灣","選票","柯市長","民進黨","國民黨","台北市民","市民")
new_user_word(mixseg,segment)

#有詞頻之後就可以去畫文字雲
jieba_tokenizer=function(d){
  unlist(segment(d[[1]],mixseg))
}
seg = lapply(docs, jieba_tokenizer)
freqFrame = as.data.frame(table(unlist(seg)))
# 畫出文字雲
# 儲存文字雲圖片
png("Ko_Apr.png", width = 500, height = 500 )

wordcloud(freqFrame$Var1,freqFrame$Freq,
          min.freq=70,
          random.order=TRUE,random.color=TRUE, 
          rot.per=.1, colors=rainbow(length(row.names(freqFrame))),
          ordered.colors=FALSE,use.r.layout=FALSE,
          fixed.asp=TRUE)
dev.off()

#====== 5月切詞
docs <- Corpus(VectorSource(data_5$bindtext))
toSpace <- content_transformer(function(x,pattern){
  return(gsub(pattern," ",x))
})
# 刪去單詞贅字、英文字母、標點符號、數字與空格
docs <- tm_map(docs, toSpace, " 為達最佳瀏覽效果，建議使用 Chrome、Firefox 或 Internet Explorer 10")
docs <- tm_map(docs, toSpace, "新聞送上來！快加入自由電子報APP、LINE好友  2018年6月13日‧星期三‧戊戌年四月卅 注目新聞 1 中國卡車罷工延燒 司機高喊「打倒共產黨」！ 2 新版身分證票選出爐 設計師魯少綸奪首獎！ 3 洋腸又來！夜店外帶18歲妹 網站取名「台女很容易」... 4 侯友宜妻1塊土地99個門牌 蘇貞昌：太荒唐 5 連俞涵超正弟媳曝光…根本巨乳林志玲！")
docs <- tm_map(docs, toSpace, "以上版本的瀏覽器。 爆")
docs <- tm_map(docs,toSpace,"\n")
docs <- tm_map(docs,toSpace, "[A-Za-z0-9]")
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
docs <- tm_map(docs, toSpace, "的")
docs <- tm_map(docs, toSpace, "也")
docs <- tm_map(docs, toSpace, "都")
docs <- tm_map(docs, toSpace, "就")
docs <- tm_map(docs, toSpace, "與")
docs <- tm_map(docs, toSpace, "但")
docs <- tm_map(docs, toSpace, "是")
docs <- tm_map(docs, toSpace, "在")
docs <- tm_map(docs, toSpace, "和")
docs <- tm_map(docs, toSpace, "及")
docs <- tm_map(docs, toSpace, "為")
docs <- tm_map(docs, toSpace, "或")
docs <- tm_map(docs, toSpace, "且")
docs <- tm_map(docs, toSpace, "有")
docs <- tm_map(docs, toSpace, "含")
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, toSpace, "[a-zA-Z]")
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, removePunctuation)
# 匯入自定義字典
mixseg = worker()
segment <- c("柯文哲","姚文智","丁守中","台北市長","選舉","候選人","台灣","選票","柯市長","民進黨","國民黨","台北市民","市民")
new_user_word(mixseg,segment)

#有詞頻之後就可以去畫文字雲
jieba_tokenizer=function(d){
  unlist(segment(d[[1]],mixseg))
}
seg = lapply(docs, jieba_tokenizer)
freqFrame = as.data.frame(table(unlist(seg)))
# 畫出文字雲
# 儲存文字雲圖片
png("Ko_May.png", width = 500, height = 500 )

wordcloud(freqFrame$Var1,freqFrame$Freq,
          min.freq=70,
          random.order=TRUE,random.color=TRUE, 
          rot.per=.1, colors=rainbow(length(row.names(freqFrame))),
          ordered.colors=FALSE,use.r.layout=FALSE,
          fixed.asp=TRUE)
dev.off()




