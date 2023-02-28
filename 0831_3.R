View(cars)
ggplot(cars,aes(speed,dist)) + geom_point()

plot(cars)
pairs(cars)

cor(cars)

#p-value 작을수록 좋음
cor.test(cars$speed, cars$dist)

#선형회귀 함수식
x <- lm(dist~speed, data=cars)

x
summary(x)
str(x)

df1 <- data.frame(speed=20)
predict(x,df1)

predict(x,data.frame(speed=c(20,120)))

#신뢰도
predict(x,df1,interval="confidence")

#geom_point에 lm선 그리는법법
ggplot(data=mpg,aes(x=displ,y=cty,color=drv)) + geom_point() + geom_smooth(method='lm')
