# 推薦讀物 ####
#   0. RStudio Cheat Sheet: https://www.rstudio.com/resources/cheatsheets/
#   1. R in Action: http://www.amazon.com/R-Action-Robert-Kabacoff/dp/1935182390/ref=sr_1_1?s=books&ie=UTF8&qid=1399278766&sr=1-1&keywords=r+in+action
#   2. R for Everyone: Advanced Analytics and Graphics: http://www.amazon.com/Everyone-Advanced-Analytics-Graphics-Addison-Wesley/dp/0321888030
#   3. Advanced R: http://adv-r.had.co.nz/
#   4. ggplot2: Elegant Graphics for Data Analysis (Use R!):   http://www.amazon.com/ggplot2-Elegant-Graphics-Data-Analysis/dp/0387981403

#### 為何要用 R  ####
if (!require(quantmod)) install.packages('quantmod')

# Youtube 教學：https://www.youtube.com/watch?v=BMhk2W2CTI8
TWII <- getSymbols(Symbols='^TWII', src='yahoo', from='2015-08-01', auto.assign = FALSE)   

# 比較好的寫法 (物件抽離)
Ticker = '^TWII'        # ^TWII: 台灣加權股價指數 (http://finance.yahoo.com/q?s=^TWII)
Date   = '2015-08-01'
TWII <- getSymbols(Symbols=Ticker, src='yahoo', from=Date, auto.assign = FALSE)   

# 繪製股票圖形
chartSeries(TWII)
chartSeries(TWII, theme='white')    
chartSeries(TWII, theme='white', TA='addSMA(5);addSMA(20)')


#### Hot Key ####
# Ctrl + Enter: Run Selected Line
#
# Tab: 自動完成 (善用之！)
# 
# Ctrl + Shift + C: 註解選取列
# 
# Ctrl + F: 搜尋程式碼
# Ctrl + Shift + J: 搜尋且取代程式碼
# 
# Ctrl + L: 清除 Console Windows


# 創建 Section 區塊 #### 


#### Packages 相關指令 ####
library()     # 顯示已安裝的套件
search()      # 顯示已載入的套件套件
.libPaths()   # 顯示 library 存放位置

# install.package('套件名稱')
# install.package("套件名稱")     # 單引號 ' 與 雙引號 " 的選擇
install.packages('ctv')           # 安裝ctv (CRAN Tasks Views) 套件: http://cran.r-project.org/web/views/
# install.packages('ctv', dependencies = TRUE)
# install.packages('ctv', type='source')

library(ctv)                      # 載入 ctv 套件
require(ctv)                      # library() 與 requrie() 的差異：error vs. warning

if (!require(ctv)) install.packages('ctv')
# if (!require(ctv)) install.packages('ctv', dependencies = TRUE)
# if (!require(ctv)) install.packages('ctv', type='source')

# install.views('Econometrics')   # 安裝特定 ctv 群組的相關套件
# update.views('Econometrics')    # 更新特定 ctv 群組的相關套件

#### 基本操作區 ####
aaa <- 0.12345                 # 一般指派： <- / = ；進階指派： <-- / assign()
aaa = 0.12345                  # <- vs =：程式計用途時，僅支援 <- (gets) 的用法！
0.12345 -> aaa                 # 不建議使用！

rm(list=ls())    # 清除記憶體 (留意使用！)
options(digits=3)              # 設定數值顯示位數

0.12345

# 工作路徑之相關語法
getwd()                                    # 查詢目前的工作目錄 working directory
setwd('C:/Users/EC/Desktop/codes')         # 切換工作目錄至指定路徑
setwd('C:\\Users\\EC\\Desktop\\codes')     # / vs \\ 的選擇
setwd('C:\Users\EC\Desktop\codes')         # <----- 錯誤的語法！

#### 讀取單一本地檔案 ####
?read.table         # 查詢特定語法的說明
help(read.table)    # ? vs help
??read              # 搜尋特定關鍵詞有關的語法

### 讀取 txt  檔案 (Tab 分隔)
MyData <- read.table('./Data0/MyData.txt', sep="\t")   
# \t：Tab 的 escape 字元
# ./Data0/：相對路徑的用法

class(MyData)    # 查詢物件的型態
View(MyData)     # 檢視物件內容
names(MyData)    # 查詢物件的欄位名稱
MyData <- read.table('./Data0/MyData.txt', sep="\t", header=TRUE) 
str(MyData)      # 查詢 dataset 的屬性
head(MyData)     # 查詢 dataset 的頭 n 筆資料 (n 預設為 5)
tail(MyData)     # 查詢 dataset 的尾 n 筆資料 (n 預設為 5)
tail(MyData, 10) # 查詢 dataset 的頭 n 筆資料 (n 自定)

object.size(MyData)   # 查詢物件占用的記憶體空間

### 讀取 csv 檔案 (逗點 , 分隔)
MyData1 <- read.table('./Data0/MyData.csv', sep=',', header=TRUE)
str(MyData1)
tail(MyData1)

# 讀取 URL 檔案 (為 Data Mining 與 Machine Learning 預做準備) ####
# Machine Learning - Open Data Source: 
#   http://archive.ics.uci.edu/ml/datasets.html
#   http://archive.ics.uci.edu/ml/machine-learning-databases/echocardiogram/     
MyUrl <- "http://archive.ics.uci.edu/ml/machine-learning-databases/echocardiogram/echocardiogram.data"
ECCdata <- read.csv(MyUrl, header=T)

# 讀取 URL 網頁 ####
if (!require(XML)) install.packages('XML')
MyUrl <- "http://en.wikipedia.org/wiki/List_of_countries_by_credit_rating"
CountryRating <- readHTMLTable(readLines(MyUrl), which=3)
head(CountryRating)
CountryRating$Rating <- substring(CountryRating$Rating, first = 3, last = 10)
head(CountryRating)
CountryRating <- CountryRating[,-length(CountryRating)]
head(CountryRating)

# 讀取 xlsx / xls 檔案 (使用 xlsx 套件)
if (!require(xlsx)) install.packages('xlsx')
# if (!require(xlsx)) install.packages('xlsx', type = 'source')
# if (!require(xlsx)) install.packages('xlsx', dependencies = TRUE)

MyData2 <- read.xlsx('./Data0/MyData.xlsx', sheetIndex=1) 
MyData2 <- read.xlsx('./Data0/MyData.xlsx', sheetName='Sheet1')
str(MyData2)

#### 讀取多個本地檔案 ####
rm(list=ls())    # 清除記憶體

MyPath <- './Data/'        # 設定資料放置的路徑 (相對路徑)
FileList <- list.files(path=MyPath, pattern='xls')    # 讀取特定路徑下的特定型態檔案之檔名資訊
FileList
FileList <- dir(path=MyPath, pattern='xls')
FileList

n <- length(FileList)

MyDF <- data.frame()              # 建置一個空的 data.frame
for(i in 1:n) {
  Temp <- read.xlsx(paste(MyPath, FileList[i], sep=""), 1)
  MyDF <- rbind(MyDF, Temp)       # 重直合併 (append)
  rm(Temp)                        # 清除不必要的 Temp
}

rm(FileList, i, n, MyPath)        # 清除掉不必要的變數

# 函式化

READ.XLS <- function(MyPath){
  if (!require(xlsx)) install.packages('xlsx')
  library(xlsx)
  FileList <- dir(path=MyPath, pattern='xls')
  n <- length(FileList)
  MyDF <- data.frame()              # 建置一個空的 data.frame
  for(i in 1:n) {
    Temp <- read.xlsx(paste(MyPath, FileList[i], sep=""), 1)
    MyDF <- rbind(MyDF, Temp)       # 重直合併 (append)
    rm(Temp)                        # 清除不必要的 Temp
  }
  return(MyDF)
}

MyDF <- READ.XLS(MyPath)

# Checking Data
names(MyDF)
str(MyDF)
head(MyDF)
head(MyDF, 10)
tail(MyDF)

# Adding Field
Year  <- format(MyDF$valDate , "%Y") # %Y: Year with century
Month <- format(MyDF$valDate , "%m") # %m: Month (注意：是 m 不是 M)
# http://stackoverflow.com/questions/9749598/r-obtaining-month-and-year-from-a-date
MyDF <- cbind(Year, Month, MyDF)
str(MyDF)      # 查閱 data.frame 的欄位屬性 (型態)

# Indexing 指標：探詢物件的子集
MyDF[12]
MyDF[[12]]
MyDF$indexQuality
MyDF[1:2,12]
MyDF[[12]][1:2]
MyDF$indexQuality[1:2]
MyDF$"查閱"           # 如果欄位名稱為中文的話

MyDF[1:2, 11:12]
MyDF[1:2, c(2,12)]

mylist <- c(1, 3, 10, 11:20)
MyDF[mylist, c(2,12)]

MyDF[MyDF$ticker == 'BVU' | MyDF$ticker == 'ITI', ]

with(MyDF, 
     MyDF[ticker == 'BVU' | ticker == 'ITI', ]
     #  
)

subset(MyDF, ticker == 'BVU' | ticker == 'ITI')

subset(MyDF, ticker == c('BVU', 'ITI'))

subset(MyDF, ticker == c('BVU','ITI') & indexQuality == c('BBB','BBB+'))

# 選取子集 Subsetting Data
start <- as.Date('1990-1-1')      # 定義資料起點
end <- as.Date('2000-12-31')      # 定義資料結點
MyDF1 <- MyDF[MyDF$valDate >= start & MyDF$valDate <= end,]
MyDF1 <- MyDF[with(MyDF, valDate >= start & valDate <= end),]
MyDF2 <- subset(MyDF, valDate >= start & valDate <= end)

# Ordering Data 
MyDF3 <- MyDF[order(MyDF$indexQuality, MyDF$valDate), ]

# Factor 變數之轉換: nominal --> ordinal
levels(MyDF$indexQuality)   # 查看變數 (Factor 型態) 的 levels 類別
summary(MyDF)  # 對某變數進行摘要統計

Levels_NewDef <- c("BBB-", "BBB", "BBB+", "A-", "A", "A+", "AA-", "AA", "AA+", "AAA-", "AAA", "AAA+")
MyDF$indexQuality1 <- factor(MyDF$indexQuality, levels=Levels_NewDef, ordered=T)
str(MyDF)        # factor (nomial scale) vs. ordered factor (ordinal scale)
levels(MyDF$indexQuality1)
unique(MyDF$indexQuality1)

by(MyDF$marketValue, MyDF$indexQuality1, function(m) summary(m))   # 對某變數進行分組摘要統計

MyDF1 <- MyDF[which(MyDF$indexQuality1 > 'A'),]    # 利用有序的 factor 取出子集

# Ordering Data (Again)
MyDF3 <- MyDF[order(MyDF$indexQuality1, MyDF$valDate, decreasing = TRUE),]


#### data.frame 橫向合併 (債券+股價) ####
if (!require(quantmod)) install.packages('quantmod')

# ^GSPC: S&P 500 (http://finance.yahoo.com/q?s=^GSPC)
GSPC <- getSymbols(Symbols='^GSPC', src='yahoo', from='1980-01-01', auto.assign = FALSE)   
# GSPC <- getSymbols(Symbols='^GSPC', src='yahoo', from='1980-01-01', to='2000-12-31', auto.assign = FALSE)   

# XTS to dataframe: http://stackoverflow.com/questions/3386850/how-can-i-change-xts-to-data-frame-and-keep-index-in-r
GSPC.DF <- data.frame(date=index(GSPC), coredata(GSPC))
MyDF2 <- merge(MyDF, GSPC.DF, by.x = "valDate", by.y = "date", all.x=T)
MyDF3 <- na.omit(MyDF2)

# 將 data.frame 寫出檔案
write.table(MyDF3, './OutFile/MyDF2.txt', append = F, quote = F, row.names = F, sep = "\t")
write.table(MyDF3, './OutFile/MyDF2.csv', append = F, row.names = F, quote = F)
write.xlsx(MyDF3, './OutFile/MyDF2.xlsx', sheetName="Sheet1", 
           col.names=T, row.names=F, append=F, showNA=T)

save(MyDF3, file = './OutFile/MyDF3.rdata')       # 如果後續仍要用 R 分析，建議儲存成 .rdata 的格式
rm(MyDF3)
load('./OutFile/MyDF2.rdata')                     # 載入 .rdata 的資料


#### 敘述統計 ####
## 單變量 (不分群) 敘述統計
# summary: 內建的 Descriptive Statistics 函式
summary(MyDF$marketValue)

# dstats: 自建的 Descriptive Statistics 函式
dstats <- function(x){
              c(n=length(x),
                na=sum(is.na(x)),     # 計算 missing value
                mean=mean(x, na.rm=T),
                median=median(x, na.rm=T),
                sd=sd(x, na.rm=T))
}
dstats(MyDF$marketValue)

# aggregate #### 
# 單變量 (分群) 敘述統計 aggregate + summary)
res.summary <- aggregate(data=MyDF, 
                        marketValue ~ Year + indexQuality,
                        FUN=summary)  # summary: Descriptive Statistics
res.summary <- as.data.frame(as.list(res.summary))    # BUG: http://stackoverflow.com/questions/12064202/using-aggregate-for-multiple-aggregations
res.summary

res.dstats <- aggregate(data=MyDF, 
                        marketValue ~ Year+ indexQuality, 
                        FUN=dstats)
res.dstats <- as.data.frame(as.list(res.dstats)) # BUG: http://stackoverflow.com/questions/12064202/using-aggregate-for-multiple-aggregations
res.dstats
str(res.dstats)

levels(res.dstats$indexQuality)
Levels_NewDef <- c("BBB-", "BBB", "BBB+", "A-", "A", "A+", "AA-", "AA", "AA+", "AAA-", "AAA", "AAA+")
res.dstats$indexQuality <- factor(res.dstats$indexQuality, levels=Levels_NewDef, ordered=T)
# order: 排序資料
res.dstats <- res.dstats[with(res.dstats, order(indexQuality, Year)), ] 

# by #### 單變量 (分群) 敘述統計 by + summary)
with(MyDF,
     by(marketValue, INDICES=list(Year, indexQuality), function(m) summary(m))   # 對某變數進行分組摘要統計
)

# {sjPlot} 類似 SPSS 表格輸出的套件 ####
if(!require(sjPlot)) install.packages('sjPlot')
sjt.df(MyDF)

sjt.df(MyDF[1:100,], alternateRowColors=TRUE,     # 為節省時間，採用子集合展演
       orderColumn='indexQuality', describe=FALSE)   

sjt.xtab(MyDF$Year, MyDF$indexQuality)

# {xtable} #### (略)
# if(!require(xtable)) install.packages('xtable')

# {plyr} ####
if(!require(plyr)) install.packages('plyr')

res.plyr <- ddply(MyDF, .(Year, indexQuality), summarize,
                  na=sum(is.na(marketValue)),
                  mean=mean(marketValue, na.rm=T),
                  median=median(marketValue, na.rm=T),
                  sd=sd(marketValue, na.rm=T)
                 )
View(res.plyr)
res.plyr1 <- res.plyr[res.plyr$mean > 50,]

# {data.table} ####
#  http://stackoverflow.com/questions/14035872/ddply-for-sum-by-group-in-r
#  http://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.pdf
if(!require(data.table)) install.packages('data.table')
res.data.table <- data.table(MyDF)[ , 
                                   list(na=sum(is.na(marketValue)),
                                        mean=mean(marketValue), 
                                        median=median(marketValue, na.rm=T),
                                        sd=sd(marketValue) ), 
                                   by='Year,indexQuality'
                                  ][mean > 50]
View(res.data.table)

# {reshape} & {reshape2} (Hint: melt + cast)
if(!require(reshape)) install.packages('reshape')
# if(!require(reshape2)) install.packages('reshape2')

md.MyDF <- melt(MyDF, measure.vars=c('marketValue','coupon'), id.vars=c('Year','indexQuality1'))
head(md.MyDF)

cd1 <- cast(md.MyDF, Year + indexQuality1 + variable ~ . , summary)
# sorting
#   http://stackoverflow.com/questions/1296646/how-to-sort-a-dataframe-by-columns-in-r
cd1 <- cd1[with(cd1, order(variable, Year, indexQuality1)), ]
head(cd1)

cd2 <- cast(md.MyDF, indexQuality1 + variable ~ ., summary)
head(cd2)

## {tidyr}
# if(!require(xlsx)) install.packages('xlsx')   
# HI <- read.xlsx('./Data0/可能成交指數.xlsx', sheetIndex = 1,  encoding="big5")
# str(HI)

if(!require(readxl)) install.packages('readxl')    # {readxl} vs. {read.xlsx}
HI <- read_excel('./Data0/可能成交指數.xlsx', sheet =  1)
str(HI)
head(HI)

# separate()
if(!require(tidyr)) install.packages('tidyr')
HI1 <- HI %>% separate(年度季別, c('年度','季別'), sep=3)
head(HI1)

# unite()
HI2 <- HI1 %>% unite(年度季別, 年度, 季別, sep='')
head(HI2)

## Long format vs. Wide format
# gather()
HI4 <- HI %>% gather(地區, 指數, 全國, 台北市, 新北市, 桃竹地區, 台中市, 台南市, 高雄市)
head(HI4)

# spread()
HI5 <- HI4 %>% spread(地區, 指數)
head(HI5)

# cd_tidyr <- MyDF %>%   (indexQuality, marketValue, coupon)
cd_tidyr <- MyDF %>%  gather(indexQuality, marketValue, coupon)

## {dplyr}
if(!require(dplyr)) install.packages('dplyr')

# Subsetting: select()
names(HI1)
sub.HI1 <- HI1 %>% select(年度, 季別,全國)
head(sub.HI1)
sub.HI1 <- HI1 %>% select(-全國)
head(sub.HI1)

# Subsetting: filter()
sub.HI1 <- HI1 %>% filter(季別 == 'Q4')
head(sub.HI1)

# select() + filter()
sub.HI1 <- HI1 %>% 
              select(-全國) %>%
              filter(季別 == 'Q4')
head(sub.HI1)

sub1.HI1 <- HI1 %>% 
              select(-全國) %>%
              filter(季別 == 'Q4') %>%
              select(-季別)
head(sub1.HI1)

# Grouping for Summary Statistics: group_by()  [silent function]
group.MyDF <- MyDF %>% group_by(indexQuality)
head(group.MyDF)

# Summary Statistics: summarize() / summarise()
MyDF %>% summarize(mean.marketValue = mean(marketValue))
group.MyDF %>% summarize(mean.marketValue = mean(marketValue),
                         std.marketValue = sd(marketValue))

dstat.MyDF <- MyDF %>% 
                group_by(Year, indexQuality) %>%
                summarize(mean.marketValue = mean(marketValue),
                          std.marketValue = sd(marketValue))
head(dstat.MyDF)

dstat.MyDF <- MyDF %>% 
  group_by(Year, indexQuality1) %>%
  summarize(mean.marketValue = mean(marketValue, na.rm=TRUE), 
            sd.marketValue = sd(marketValue, na.rm=TRUE),
            n.marketValue = n())
dstat.MyDF

# arrange() + desc()
arrange.dstat.MyDF <- dstat.MyDF[order(dstat.MyDF$n.marketValue, decreasing=T), ]
arrange.dstat.MyDF

arrange.dstat.MyDF <- dstat.MyDF %>%
                        ungroup() %>%    # 注意，對於有 group_by() 過的 dataset，必須執行此步驟才能做 arrange()   http://stackoverflow.com/questions/27207963/arrange-not-working-on-grouped-data-frame
                        arrange(desc(n.marketValue))
arrange.dstat.MyDF

# mutate()
mutate.MyDF <- MyDF %>%
  mutate(perc_coupon = coupon / 100)  # 注意：這邊只是舉例，留意可能重複的狀況
head(mutate.MyDF)

arrange.dstat.MyDF <- dstat.MyDF %>%
  ungroup() %>%    # 注意，對於有 group_by() 過的 dataset，必須執行此步驟才能做 arrange()   http://stackoverflow.com/questions/27207963/arrange-not-working-on-grouped-data-frame
  arrange(desc(n.marketValue)) %>%
  mutate(Rank = 1:length(n.marketValue))  # 注意：這邊只是舉例，留意可能重複的狀況
arrange.dstat.MyDF


# join() [left_join() / right_join() / inner_join() / full_join() / semi_join() / anti_join() ]
MyDF2 <- merge(MyDF, GSPC.DF, by.x = "valDate", by.y = "date", all.x=T)
MyDF2 <- na.omit(MyDF2)


MyDF3 <- left_join(MyDF, GSPC.DF, by=c('valDate' = 'date')) %>%  # ?left_join: To join by different variables on x and y use a named vector. For example, by = c("a" = "b") will match x.a to y.b.
         na.omit()        # http://stackoverflow.com/questions/26665319/removing-na-in-dplyr-pipe

# 自己試試看別種 join() 【請自行上網查詢 SQL 的 join() 說明】
# MyDF4 <- inner_join(MyDF, GSPC.DF, by=c('valDate' = 'date'))


#### Data Visualization ####
data(mtcars)  # https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html
str(mtcars)

## Scattor Plot ####
plot(mtcars$wt, mtcars$mpg)

# {ggplot2} 強大的繪圖套件 ####
if(!require(ggplot2)) install.packages('ggplot2')
qplot(mtcars$wt, mtcars$mpg)
qplot(wt, mpg, data = mtcars)
ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()

## Line Chart ####
data("pressure")
plot(pressure$temperature, pressure$pressure)
lines(pressure$temperature, pressure$pressure, col='red')
points(pressure$temperature, pressure$pressure/2)
lines(pressure$temperature, pressure$pressure/2, col='blue')

qplot(temperature, pressure, data = pressure, geom = c('line','point'))
ggplot(pressure, aes(x=temperature, y=pressure)) + geom_line() + geom_point()

## MyDF 
qplot(marketValue, data=MyDF, ..density.., geom='histogram', alpha=I(1/3))
qplot(marketValue, data=MyDF, geom='histogram', binwidth=10, alpha=I(1/3))

qplot(marketValue, ..density.. , data=MyDF1, facets= Year~ indexQuality1, geom='histogram', alpha=I(1/3))
qplot(indexQuality1, marketValue, data=MyDF1, geom='jitter', alpha=I(1/3))

# {googleVis} 互動繪圖套件 ####
# 請從 HTML 的 Slide 中複製 Code 過來這邊實作
