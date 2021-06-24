library(readxl)
data<-read_excel("data.xlsx",1)
str(data)
head(data)
fit <- lm( time~result_average ,data=data)  
summary(fit)
plot(data$result_average,data$time,
     xlab="result_average",
     ylab="time")
abline(fit)
fit <- lm(time~result_average ,data=data)
par(mfrow=c(2,2))
plot(fit)
SSE<-sum(fit$residuals^2)
SSE
RMSE<-sqrt(SSE/nrow(data))
RMSE