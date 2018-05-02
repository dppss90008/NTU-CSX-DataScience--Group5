library(magrittr)

# Read the titanicTrain data and store it in titanic
getwd()
train <- read.csv("titanicTrain.csv")
train <- train[c(1:1000),]

# Train data 上面的NA
str(train)
sapply(train, function(x) {sum(is.na(x))})


# Pclass 
ggplot(train[!is.na(train$survived),], aes(x = pclass, fill = survived)) +
  geom_bar(stat='count', position='dodge') + labs(x = 'Train data') +
  theme(legend.position="none") + theme_grey() +
  geom_label(stat='count', aes(label=..count..))
  
# Sex
ggplot(train[!is.na(train$survived),], aes(x = sex, fill = survived)) +
  geom_bar(stat='count', position='dodge') + theme_grey() +
  labs(x = 'Train data') +
  geom_label(stat='count', aes(label=..count..))

## embarked ##
train$embarked <- train$embarked %>% as.factor
summary(train$embarked[train$survived==0])
summary(train$embarked[train$survived==1])
embark <- cbind(summary(train$embarked[train$survived==0]),summary(train$embarked[train$survived==1]))
embark <- embark[-1,] %>% t
rownames(embark) <- c("0","1")

barplot(embark,col=c("gray","black"),main="embarked variable",beside=TRUE,ylab="counts")
legend("topright", inset=.02,title="Survive",
       c("0","1"), fill=c("gray","black"), horiz=TRUE, cex=0.8)

## family = sibsp + parch + 1  ##

family <- train$parch + train$sibsp + 1
train <- cbind(train,family)

ps0 <- train$family[train$survived==0] %>% as.factor %>% summary
ps1 <- train$family[train$survived==1] %>% as.factor %>% summary %>% c(.,0)
family <- rbind(ps0,ps1)
rm(ps0)
rm(ps1)

barplot(family,col=c("gray","black"),main="family",beside=TRUE,ylab="counts",xlab="Number of people")
legend("topright", inset=.02,title="Survive",
       c("0","1"), fill=c("gray","black"), horiz=TRUE, cex=0.8)

