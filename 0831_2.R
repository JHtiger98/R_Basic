package1 <- c("ggplot2", "Rcpp", "dplyr", "ggthemes", "ggmap", "devtools", "RCurl", "igraph", "rgl", "lavaan", "semPlot")
package2 <- c("twitteR", "XML", "plyr", "doBy", "RJSONIO", "tm", "RWeka", "base64enc")
list.of.packages <-  c( package1, package2)
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages) 


library(plyr)
library(stringr)

#Samsung--------
samsung_tweets <- searchTwitter("samsung", lang="en", n=1000)
rm(samsung_tweets)
save(samsung_tweets, "samsung_tweetes.rda")
load("samsung_tweets.rda")

st <- twListToDF(samsung_tweets)
head(st)
names(st)
#View(st)

st_text <- st$text

st_text <- gsub("\\W", " ", st_text)
st_df <- as.data.frame(st_text)
st_df

#apple---------
apple_tweets <- searchTwitter("apple", lang="en", n=1000)
rm(apple_tweets)
save(apple_tweets, "apple_tweetes.rda")
load("apple_tweets.rda")

at <- twListToDF(apple_tweets)
head(at)
names(at)
#View(at)

at_text <- at$text

at_text <- gsub("\\W", " ", at_text)
at_df <- as.data.frame(at_text)
at_df

#--------------------------------
# 감성사전 https://github.com/The-ECG/BigData1_1.3.3_Text-Mining  ===========

pos.word <- scan("positive-words.txt", what ="character", comment.char = ";")
neg.word <- scan("negative-words.txt", what ="character", comment.char = ";")


# https://stackoverflow.com/questions/35222946/score-sentiment-function-in-r-return-always-0

score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
  scores = laply(sentences, function(sentence, pos.words, neg.words) {
    sentence = gsub('[^A-z ]','', sentence)
    sentence = tolower(sentence);
    word.list = str_split(sentence, '\\s+');
    words = unlist(word.list);
    pos.matches = match(words, pos.words);
    neg.matches = match(words, neg.words);
    pos.matches = !is.na(pos.matches);
    neg.matches = !is.na(neg.matches);
    score = sum(pos.matches) - sum(neg.matches);
    return(score);
  }, pos.words, neg.words, .progress=.progress );
  scores.df = data.frame(score=scores, text=sentences);
  return(scores.df);
}

samsung_scores <- score.sentiment(st_text, pos.word, neg.word, .progress='text')
hist(samsung_scores$score)

apple_scores <- score.sentiment(at_text, pos.word, neg.word, .progress='text')
hist(apple_scores$score)

a <- dim(samsung_scores)[1]
b <- dim(apple_scores)[1]

alls <- rbind( as.data.frame(cbind(type=rep("samsung",a), score = samsung_scores[ , 1])),
               as.data.frame(cbind(type=rep("apple",b), score = apple_scores[ , 1])))


alls$type <- factor(alls$type)
alls$score <- as.integer(alls$score)
ggplot(alls, aes(x = score, color = type)) + geom_density() 










