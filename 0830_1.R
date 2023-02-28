library(foreign)
raw_welfare <- read.spss("Koweps_hpc10_2015_beta1.sav")

welfare <- as.data.frame(raw_welfare) 

welfare <- welfare %>% 
  rename( gender = h10_g3, birth = h10_g4, 
          marriage = h10_g10, religion = h10_g11, 
          income = p1002_8aq1, job = h10_eco9, 
          region = h10_reg7) %>% 
  select(gender, birth, marriage, religion, 
         income, job, region )

#방법1
welfare %>% filter(!is.na(income)) %>% 
  group_by(gender) %>% 
  summarise(mean_income=mean(income)) %>% 
  ggplot(aes(x=gender,y=mean_income,fill=gender)) +
  geom_col()

#방법2
welfare %>% group_by(gender) %>% summarise(mean_income=mean(income, na.rm=T)) %>% 
  ggplot(aes(x=gender,y=mean_income,fill=gender)) + geom_col()

#View(welfare)
class(welfare$birth)
summary(welfare$birth)
boxplot(welfare$birth)

welfare$age <- 2015-welfare$birth+1
summary(welfare$age)

welfare %>% filter(!is.na(welfare$income))%>%    
  group_by(age) %>%
  summarise(mean_income= mean(income)) %>% 
  ggplot(aes(x= age, y= mean_income)) + geom_line(color='skyblue', size=1) +geom_point(color='red', size=1)

welfare <- welfare %>% 
  mutate(age_gen=ifelse(age<30, "young", ifelse(age<=50, "middle", "old")))
head(welfare)

welfare %>% filter(!is.na(income)) %>% 
  group_by(age_gen) %>% summarise(mean_income = mean(income)) %>%
  ggplot(aes(x = age_gen, y = mean_income, fill = age_gen)) + geom_col()

welfare %>% group_by(age_gen, gender) %>% summarise(mean_income=mean(income, na.rm=T)) %>% ggplot(aes(x=age_gen, y=mean_income, fill=gender)) + 
  geom_col() + scale_x_discrete(limit = c("young", "middle", "old")) 

