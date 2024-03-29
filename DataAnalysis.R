library(jsonlite)
library(dplyr)


#1
library(readr)
X103_slalry_education <- read_csv("103 slalry education.csv")
X106_slalry_education <- read_csv("106 slalry education.csv")
X106_slalry_education$大職業別<- gsub("_","、",X106_slalry_education$大職業別)

X103_106_slalry_education <- inner_join(X103_slalry_education,X106_slalry_education,by="大職業別")
X103_106_slalry_education$`大學-薪資.x`<- gsub("—",0,X103_106_slalry_education$`大學-薪資.x`)
X103_106_slalry_education$`大學-薪資.y`<- gsub("—",0,X103_106_slalry_education$`大學-薪資.y`)
X103_106_slalry_education$`大學-薪資.x`<- as.numeric(X103_106_slalry_education$`大學-薪資.x`)
X103_106_slalry_education$`大學-薪資.y`<- as.numeric(X103_106_slalry_education$`大學-薪資.y`)

highersalary_106 <- filter(X103_106_slalry_education, `大學-薪資.y` > `大學-薪資.x`)

salaryrate_106 <- mutate(highersalary_106, rate = `大學-薪資.y`/ `大學-薪資.x`)
head(salaryrate_106[order(salaryrate_106$rate,decreasing = T),], 10)


salaryrate_over_1.05 <- filter(salaryrate_106, rate > 1.05)

jobtype <- strsplit(salaryrate_over_1.05$大職業別,"[-]")
strjob <- c()
for (i in 1:length(jobtype)){
  strjob[i] <- jobtype[[i]][1]
}
table(strjob)





#2
library(readr)
X103_slalry_education <- read_csv("103 slalry education.csv")
X103_slalry_education$`大學-女/男`<- gsub("—",NA,X103_slalry_education$`大學-女/男`)
X103_slalry_education$`大學-女/男`<- gsub("…",NA,X103_slalry_education$`大學-女/男`)
X103_slalry_education$`大學-女/男`<- as.numeric(X103_slalry_education$`大學-女/男`)
X103gender <- select(X103_slalry_education, 大職業別,`大學-女/男`)
X103boy <- filter(X103gender,`大學-女/男`< 100)
head(X103boy[order(X103boy$`大學-女/男`,decreasing = T),], 10)
X103girl <- filter(X103gender,`大學-女/男`> 100)

X104_slalry_education <- read_csv("104 slalry education.csv")
X104_slalry_education$`大學-女/男`<- gsub("—",NA,X104_slalry_education$`大學-女/男`)
X104_slalry_education$`大學-女/男`<- gsub("…",NA,X104_slalry_education$`大學-女/男`)
X104_slalry_education$`大學-女/男`<- as.numeric(X104_slalry_education$`大學-女/男`)
X104gender <- select(X104_slalry_education, 大職業別,`大學-女/男`)
X104boy <- filter(X104gender,`大學-女/男`< 100)
head(X104boy[order(X104boy$`大學-女/男`,decreasing = T),], 10)
X104girl <- filter(X104gender,`大學-女/男`> 100)

X105_slalry_education <- read_csv("105 slalry education.csv")
X105_slalry_education$`大學-女/男`<- gsub("—",NA,X105_slalry_education$`大學-女/男`)
X105_slalry_education$`大學-女/男`<- gsub("…",NA,X105_slalry_education$`大學-女/男`)
X105_slalry_education$`大學-女/男`<- as.numeric(X105_slalry_education$`大學-女/男`)
X105gender <- select(X105_slalry_education, 大職業別,`大學-女/男`)
X105boy <- filter(X105gender,`大學-女/男`< 100)
head(X105boy[order(X105boy$`大學-女/男`,decreasing = T),], 10)
X105girl <- filter(X105gender,`大學-女/男`> 100)

X106_slalry_education <- read_csv("106 slalry education.csv")
X106_slalry_education$大職業別<- gsub("_","、",X106_slalry_education$大職業別)
X106_slalry_education$`大學-女/男`<- gsub("—",NA,X106_slalry_education$`大學-女/男`)
X106_slalry_education$`大學-女/男`<- gsub("…",NA,X106_slalry_education$`大學-女/男`)
X106_slalry_education$`大學-女/男`<- as.numeric(X106_slalry_education$`大學-女/男`)
X106gender <- select(X106_slalry_education, 大職業別,`大學-女/男`)
X106boy <- filter(X106gender,`大學-女/男`< 100)
head(X106boy[order(X106boy$`大學-女/男`,decreasing = T),], 10)
X106girl <- filter(X106gender,`大學-女/男`> 100)



str(X103_slalry_education)



#3
library(readr)
X106_slalry_education <- read_csv("106 slalry education.csv")
X106_slalry_education$`大學-薪資`<- gsub("—",0,X106_slalry_education$`大學-薪資`)
X106_slalry_education$`研究所及以上-薪資`<- gsub("—",0,X106_slalry_education$`研究所及以上-薪資`)
X106_slalry_education$`大學-薪資`<- as.numeric(X106_slalry_education$`大學-薪資`)
X106_slalry_education$`研究所及以上-薪資`<- as.numeric(X106_slalry_education$`研究所及以上-薪資`)
X106_slalry_education$salary_differ <- X106_slalry_education$`研究所及以上-薪資`/ X106_slalry_education$`大學-薪資`

head(X106_slalry_education[order(X106_slalry_education$salary_differ,decreasing = T),], 10)


X106_slalry_education$salary_differ





#4
library(readr)

X106_slalry_education <- read_csv("106 slalry education.csv")
myfavorite <- subset(X106_slalry_education, 大職業別 == "金融及保險業-專業人員" |
                                            大職業別 == "金融及保險業-技術員及助理專業人員" |
                                            大職業別 == "金融及保險業-事務支援人員")
myfavorite <- myfavorite[,c(1,2,11,13)]


myfavorite$`大學-薪資`<- as.numeric(myfavorite$`大學-薪資`)
myfavorite$`研究所及以上-薪資`<- as.numeric(myfavorite$`研究所及以上-薪資`)
knitr::kable(mutate106 <- mutate(myfavorite, Comparesalary_106 = `研究所及以上-薪資` - `大學-薪資`))
