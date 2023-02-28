library(readxl)
excel <- read_excel("수강설문조사정리.xlsx")
#View(excel)

excel <- as.data.frame(table(excel))
excel$`수강한 과목을 선택해주세요.`
excel <- excel %>% 
  rename(Satisfy = `강의 내용 만족도 [2. 나의 학습태도는 적극적이며 성실히 수업에 참여하고 있다고 생각하나요?]`, 
         PorR =`수강한 과목을 선택해주세요.` ) %>% 
  select(Satisfy, PorR)

excel <- excel %>% 
  mutate(Sat_Num = ifelse(excel$Satisfy == "전혀 동의하지 않음", 0, 
                          ifelse(excel$Satisfy == "동의하지 않음", 1,
                                 ifelse(excel$Satisfy == "보통", 2, 
                                        ifelse(excel$Satisfy == "동의함", 3, 
                                               ifelse(excel$Satisfy == "매우 동의함", 4, excel$Satisfy))))))


#View(excel)

excel %>% group_by(PorR,Sat_Num) %>% 
  summarise(sum_count = sum(Sat_Num)) %>% 
  ggplot(aes(x=PorR, y=sum_count, fill=PorR)) + geom_col()
