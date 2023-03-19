setwd("C:/Users/Administrator/Desktop/du_an_KTL/du_lieu_chinh")
getwd()

#Doc file du lieu:
library(readxl)				
test = read_excel("du_lieu_chinh.xlsx", sheet = 1)

#Thong ke mo ta:
#Thong ke cac bien dinh tinh:
library(table1) 
table1 (~total_deaths + total_vaccinations + population_2020 +aged_70_older+ 
      gdp_per_capita + diabetes_prevalence + low_HDI + medium_HDI + high_HDI, data = test)

#Phu luc:
#Thong ke bien gia:
#Ma hoa cac quoc gia:
test$phat_trien[test$HDI == 1] = "Thap"
test$phat_trien[test$HDI == 2] = "Trung binh"
test$phat_trien[test$HDI == 3] = "Cao"
test$phat_trien[test$HDI == 4] = "Rat cao"
#Ve bieu do:
dfa = table (test$phat_trien)
options (digits = 3)
dfb = prop.table(dfa)
dfc = paste(names(dfa), round(dfb*100,digits = 1), "%")
pie(dfa, labels = dfc, col = c("red","yellow","green","blue"), main = "Bieu do tron the hien ty le % xep hang chi so phat trien con nguoi cac quoc gia")
#Thong ke mo ta bien dinh tinh:
library(gmodels)
CrossTable (test$low_HDI)
CrossTable(test$medium_HDI)
CrossTable (test$high_HDI)
CrossTable (test$very_high_HDI)


#Ve do thi histogram cho bien total_death:
a = hist(test$total_deaths, ylim = c(0,150), col = "yellow", main = "")
b <- seq(min(test$total_deaths), max(test$total_deaths), length = 40) 
c <- dnorm(b, mean = mean(test$total_deaths), sd = sd(test$total_deaths)) 
c <- c * diff(a$mids[1:2]) * length(test$total_deaths) 
lines(b, c, col = "black", lwd = 2)

#Ve do thi histogram cho bien lndeath:
h = hist (test$lndeath, breaks=10, ylim=c(0, 30), col = "red", main = "")
xfit <- seq(min(test$lndeath), max(test$lndeath), length = 40) 
yfit <- dnorm(xfit, mean = mean(test$lndeath), sd = sd(test$lndeath)) 
yfit <- yfit * diff(h$mids[1:2]) * length(test$lndeath) 
lines(xfit, yfit, col = "black", lwd = 1)

#He so tuong quan Pearson giua cac bien:
cor (test$high_HDI, test$lndeath)
cor (test$high_HDI, test$ln_vaccine)
cor (test$high_HDI, test$ln_pop)
cor (test$high_HDI, test$aged_70_older)
cor (test$high_HDI, test$gdp_per_capita)
cor (test$high_HDI, test$diabetes_prevalence)
cor (test$high_HDI, test$low_HDI)
cor (test$high_HDI, test$medium_HDI)

cor (test$medium_HDI, test$lndeath)
cor (test$medium_HDI, test$ln_vaccine)
cor (test$medium_HDI, test$ln_pop)
cor (test$medium_HDI, test$aged_70_older)
cor (test$medium_HDI, test$gdp_per_capita)
cor (test$medium_HDI, test$diabetes_prevalence)
cor (test$medium_HDI, test$low_HDI)

cor (test$low_HDI, test$lndeath)
cor (test$low_HDI, test$ln_vaccine)
cor (test$low_HDI, test$ln_pop)
cor (test$low_HDI, test$aged_70_older)
cor (test$low_HDI, test$gdp_per_capita)
cor (test$low_HDI, test$diabetes_prevalence)

cor (test$diabetes_prevalence, test$lndeath)
cor (test$diabetes_prevalence, test$ln_vaccine)
cor (test$diabetes_prevalence, test$ln_pop)
cor (test$diabetes_prevalence, test$aged_70_older)
cor (test$diabetes_prevalence, test$gdp_per_capita)

cor (test$gdp_per_capita, test$lndeath)
cor (test$gdp_per_capita, test$ln_vaccine)
cor (test$gdp_per_capita, test$ln_pop)
cor (test$gdp_per_capita, test$aged_70_older)

cor (test$aged_70_older, test$lndeath)
cor (test$aged_70_older, test$ln_vaccine)
cor (test$aged_70_older, test$ln_pop)

cor (test$ln_pop, test$lndeath)
cor (test$ln_pop, test$ln_vaccine)

cor (test$ln_vaccine, test$lndeath)

#Chay hoi quy:
df1 = lm (data=test, lndeath ~ ln_vaccine + ln_pop + aged_70_older + gdp_per_capita
    + diabetes_prevalence + low_HDI + medium_HDI + high_HDI)

#Rut gon va xuat ket qua:
library(jtools)
library(officer)
library(flextable)
set_summ_defaults(digits = 3, model.info = TRUE, model.fit = TRUE, confint = TRUE, vifs = TRUE, pvals = TRUE, robust = TRUE)
summ (df1)
export_summs(df1, statistics = "all",  robust = TRUE, scale = TRUE, to.file = "docx", file.name = "ket_qua_chay_tren_R.docx")

#Kiem dinh RESET xem mo hinh df1 co phu hop khong:
#Kiem dinh voi y2, y3:
library(lmtest)
resettest(df1, power = 2:3 , type = "fitted")
#kiem dinh voi y2, y3, y4:
resettest(df1, power = 2:4 , type = "fitted")


#Kiem dinh Fisher:
library(car)
linearHypothesis(df1, c("ln_vaccine=0","ln_pop=0","aged_70_older=0","gdp_per_capita=0","diabetes_prevalence=0","low_HDI=0","medium_HDI=0","high_HDI=0"))

#Kiem dinh phuong sai thay doi:
library(lmtest)
bptest(df1)

#Kiem dinh phan phoi chuan:
test$residual = residuals(df1)
shapiro.test(test$residual)

#Kiem dinh da cong tuyen:
vif (df1)


