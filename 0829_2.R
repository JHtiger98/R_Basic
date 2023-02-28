library(foreign)
raw_welfare <- read.spss("Koweps_hpc10_2015_beta1.sav")

#복사본 만들기
welfare <- as.data.frame(raw_welfare) 

str(welfare)
head(welfare, 2)
summary(welfare)

ncol(welfare)
colnames(welfare)
dim(welfare)

welfare <- welfare %>% 
  rename(gender = h10_g3, birth = h10_g4, 
          marriage = h10_g10, religion = h10_g11, 
          income = p1002_8aq1, job = h10_eco9, 
          region = h10_reg7) %>%
  select(gender, birth, marriage, religion, 
         income, job, region )


View(welfare)

plot(welfare)

boxplot(welfare)
boxplot(welfare$income, welfare$job)

range(welfare$income, na.rm = T)
min(welfare$income,  na.rm = T)
max(welfare$income,  na.rm = T)

# 0을 NA로 대체합시다.
welfare$income <- ifelse(welfare$income==0 , NA  , welfare$income)


ggplot(welfare, aes(x = income, color = factor(gender))) +
  geom_density()
ggplot(welfare, aes(x = income, color = factor(gender))) +
  geom_freqpoly()

welfare$gender <-  ifelse(welfare$gender == 1, 'male', 'female')

mode(table(welfare$gender))
typeof(table(welfare$gender))

gender <- as.data.frame(table(welfare$gender))

names(gender) <- c("성별", "수입")
gender
gender %>% ggplot(aes(x = 성별, y = 수입, fill = 성별)) + geom_col()

