#install.packages("multilinguer")
library(multilinguer)
#install_jdk()

#install.packages(c("hash", "tau", "Sejong", "RSQLite", "devtools", "bit", "rex", "lazyeval", "htmlwidgets", "crosstalk", "promises", "later", "sessioninfo", "xopen", "bit64", "blob", "DBI", "memoise", "plogr", "covr", "DT", "rcmdcheck", "rversions"), type = "binary")
#install.packages("remotes")

remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))

library(KoNLP)

extractNoun('이 문장에서 명사만 추출되었다면 성공입니다.')

#Window의 한글 저장방법: "cp949"
#text <- read.csv("ahn.txt", fileEncoding="cp949")
#extractNoun()

#useNIADic()
#useSejongDic()

text <-  readLines("ahn.txt")
extractNoun(text)


nouns <-  extractNoun(text)
mode(nouns) 

nouns <- unlist(nouns)

mode(nouns) 

nouns <- nouns[nchar(nouns) > 1 ]

df <- as.data.frame(table(nouns)) %>%  arrange(desc(Freq)) %>% head(20)

ggplot(data = df, aes(x = nouns, y = Freq, fill = nouns)) +   geom_col() +  coord_flip()

wordcloud2(df)

