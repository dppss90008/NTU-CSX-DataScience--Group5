library(magrittr)
library(ggplot2)

# Read the titanicTrain data and store it in train

train <- read.csv("titanicTrain.csv")
train <- train[c(1:1000),]

# Train data 上面的NA
str(train)
sapply(train, function(x) {sum(is.na(x))})


# Pclass 
ggplot(train[!is.na(train$survived),], aes(x = pclass, fill = survived)) +
  geom_bar(stat='count', position='dodge') + labs(x = 'pClass') +
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



#load data
train <- read.csv("titanicTrain.csv", stringsAsFactors = F, na.strings = c("NA", ""))
test <- read.csv("titanicQuestion.csv", stringsAsFactors = F, na.strings = c("NA", ""))
train <- train[c(1:1000),]
#bind the data
all <- rbind(train, test)
#as factor
all$sex <- as.factor(all$sex)
all$survived <- as.factor(all$survived)

#--------boat variables

#plot b1, find out that the survived condition of "every boat"
#plot b2, see if there's anyone who survived without boat
# and who died on boat

#first we rename all boats with number 1 to 28
#tranfer original boat numbers to 1:27, 28 refer to NA  
all$boat[all$boat == "5 7"] <- "17"
all$boat[all$boat == "5 9"] <- "18"
all$boat[all$boat == "8 10"] <- "19"
all$boat[all$boat == "13 15"] <- "20"
all$boat[all$boat == "13 15 B"] <- "21"
all$boat[all$boat == "15 16"] <- "22"
all$boat[all$boat == "A"] <- "23"
all$boat[all$boat == "B"] <- "24"
all$boat[all$boat == "C"] <- "25"
all$boat[all$boat == "D"] <- "26"
all$boat[all$boat == "C D"] <- "27"
all$boat[is.na(all$boat)] <- "28"

#escape = 1 refer to the refugee who successfully took on boat
all$escape[all$boat != "28"] <- "1"
all$escape[all$boat == "28"] <- "0"
#see if taking boat is highly related survived
b1 <- ggplot(all[!is.na(all$survived),], aes(x = escape, fill = survived)) +
  geom_bar(stat='count', position='dodge') + theme_grey() +
  labs(x = 'escape from ship') +
  geom_label(stat='count', aes(label=..count..))

#subset of those who took on boat
survived_boat <- subset(all, all$boat != "28")
#see if there anyone who took on boat and didn't survive 
b2 <- ggplot(survived_boat[!is.na(survived_boat$survived),], aes(x = boat, fill = survived)) +
  geom_bar(stat='count', position='dodge') +
  labs(x = 'boat_survive') + theme_grey()

#-------what is the body variable tell us?

#replace those data to "0"(body info is NA) and "1"(body info isn't NA)
all$body[is.na(all$body)] <- "0"
all$body[all$body != "0"] <- "1"
all$body <- as.factor(all$body)
#=== guessing there is something to do with dead people

#set a subset of those which get the body's value 
have_body <- subset(all, all$body != "0")
#find out if those data with body info are highly related to death
bo <- ggplot(have_body[!is.na(have_body$survived),], aes(x = body, fill = survived)) +
  geom_bar(stat='count', position='dodge') +
  labs(x = 'body_info') + theme_grey()
#=== there isn't any survivor has body data
#=== regarding from bo, it seems those who have body info all died

#so we want to find out the distribution of survived and body
bo_2 <-ggplot(all[!is.na(all$survived),], aes(x = body, fill = survived)) +
  geom_bar(stat='count', position='dodge') + theme_grey() +
  labs(x = 'body with death') +
  geom_label(stat='count', aes(label=..count..))
#=== the outcomes of these 2 plots reveal that those who got body value was definitely dead


