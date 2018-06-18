#載入套件
library(jiebaR)
library(dplyr)
library(topicmodels)
library(tidyr)
library(stringr)
library(tidytext)

#查看路徑
getwd()

#讀檔的地方
testdoc <- read.csv("Ko_MayAppnews")
testdoc <- na.omit(testdoc)

#斷詞
cutter <- worker()
new_user_word(cutter, c("柯文哲"))
testdoc$words <- sapply(testdoc$time %>% as.character() , function(x){tryCatch({cutter[x]}, error=function(err){})})

#讀取stop words檔
fin <- file("stopwords_tw.txt", open = "r")
stopwords <- readLines(fin , encoding = "UTF8")
stopwords <- unique(stopwords) #刪去重複的stopwords

library(tidyr) # for unnest()
library(stringr)
word_token <- testdoc %>%
  unnest() %>%
  select(title, words) %>%
  filter(!(words %in% stopwords)) %>%
  filter(!str_detect(words, "\\d")) %>%
  filter(nchar(words) > 1)
# unnest words and filter words

library(tidytext)
dtm <- word_token %>%
  count(title, words) %>%
  cast_dtm(title, words, n)

raw.sum=apply(dtm,1,FUN=sum) #sum by raw each raw of the table
dtm=dtm[raw.sum!=0,]

#弄lDA的模型
library(topicmodels)
dtm_lda <- LDA(dtm, k = 16, control = list(seed = 1234)) #主題數16個
dtm_lda4 <- LDA(dtm, k = 4, control = list(seed = 1234)) #主題數4個

library(ggplot2)
dtm_topics <- tidy(dtm_lda, matrix = "beta")

top_terms <- dtm_topics %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

# View(top_terms)
top_terms %>%
  mutate(term = reorder(term, beta)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip() +
  theme(axis.text.y=element_text(colour="black", family="Heiti TC Light"))


#看topics_4的圖
dtm_topics_4 <- tidy(dtm_lda4)

top_terms_4 <- dtm_topics_4 %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

# View(top_terms_4)

top_terms_4 %>%
  mutate(term = reorder(term, beta)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip() +
  theme(axis.text.y=element_text(colour="black", family="Heiti TC Light"))


#以下是比較
perplexity(dtm_lda)
perplexity(dtm_lda4)

-(0.6*log2(0.6) + 0.4*log2(0.4))
-(0.9*log2(0.9) + 0.1*log2(0.1))


ks <- c(2, 4, 8, 14, 16, 18, 20, 24)
#我有30個doc 我不會說我有30個的topic
perplex <- sapply(ks, function(k){
  lda.temp <- LDA(dtm, k =k, control = list(seed = 1109))
  perplexity(lda.temp)
})


data_frame(k=ks, perplex=perplex) %>%
  ggplot(aes(k, perplex)) +
  geom_point() +
  geom_line() +
  labs(title = "Evaluating LDA topic models",
       subtitle = "Optimal number of topics (smaller is better)",
       x = "Number of topics",
       y = "Perplexity")



library(tidyr)

beta_spread <- dtm_topics %>%
  mutate(topic = paste0("topic", topic)) %>%
  spread(topic, beta) %>%
  select(term, topic1, topic2) %>%
  filter(topic1 > .001 | topic2 > .001) %>%
  mutate(logratio = log2(topic1 / topic2)) %>%
  arrange(desc(logratio))

beta_spread

beta_spread %>%
  group_by(logratio > 0) %>%
  top_n(20, abs(logratio)) %>%
  ungroup() %>%
  mutate(term = reorder(term, logratio)) %>%
  ggplot(aes(term, logratio, fill = logratio < 0)) +
  geom_col() +
  coord_flip() +
  ylab("Topic2/Topic1 log ratio") +
  scale_fill_manual(name = "", labels = c("topic2", "topic1"),
                    values = c("red", "lightblue")) + 
  theme(axis.text.y=element_text(colour="black", family="Heiti TC Light"))








