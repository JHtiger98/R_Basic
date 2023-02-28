View(gapminder)

gapminder %>% filter(year == 2007) %>% 
  mutate(국가분류 = ifelse(gdpPercap < 6500, "개발도상국",
                       ifelse(gdpPercap >= 23000, "선진국", "신흥국"))) 

gapminder %>% group_by(국가분류) %>% 
  summarise(mean_lifeExp = mean(lifeExp)) %>% 
  ggplot(aes(x=국가분류, y=mean_lifeExp, fill=국가분류)) + geom_col()

View(mpg)
mpg_tt4 <- mpg %>% filter(model=="toyota tacoma 4wd")
range(mpg_tt4$displ)

df <- as.data.frame(table(mpg$manufacturer)) %>%  arrange(desc(Freq)) %>% head(20)
wordcloud2(df)
