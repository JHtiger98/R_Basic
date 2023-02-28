x <- c("a","a","b","c")
qplot(x)
mode(x)
rm(x)

x1 <- 5+10
x2 <- 2*8
x3 <- "blue"
mode(x1)
mode(x2)
mode(x3)

y1 <- c(3,6,4,7,5)
y2 <- c(1,2,'abc')
mode(y1)
mode(y2)

A <- T
B <- F
C <- c(T,T)
D <- c(T,F)
mode(A)
mode(D)
A&B
C&D
A|B
C|D

x1 <- c(100,80,60,50,20)
x2 <- c("A","B","C","A","B")

df <- data.frame(x1,x2)
df

df <- data.frame(score=x1,grade=x2)
df

df$score
df$grade
mean(df$score)

