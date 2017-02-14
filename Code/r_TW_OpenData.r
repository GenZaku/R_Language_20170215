## 使用 R 讀取開放資料 (CSV, XML, JSON)
# http://www.idealyzt.com/%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8-r-%E5%8F%96%E5%BE%97%E9%96%8B%E6%94%BE%E8%B3%87%E6%96%99/
if (!require(XML)) install.packages('XML')
library(XML)

if (!require(jsonlite)) install.packages('jsonlite')
library(jsonlite)
#  http://anotherpeak.org/blog/tech/2016/03/10/understand_json_3.html
#  https://rstudio-pubs-static.s3.amazonaws.com/31702_9c22e3d1a0c44968a4a1f9656f1800ab.html

# (1) .csv
url <- 'http://data.gov.tw/iisi/logaccess/2877?dataUrl=http://file.data.gov.tw/event/dataset.csv&ndctype=CSV&ndcnid=8693'
y <- read.csv(url, sep = ",", stringsAsFactors = F, header = T, fileEncoding = "utf8")  # 'UTF-8-BOM'
head(y)

# Read a UTF-8 text file with BOM [ read.csv(..., fileEncoding = "UTF-8-BOM") ]
#  http://stackoverflow.com/questions/21624796/read-a-utf-8-text-file-with-bom

# (2) XML 
library(XML)
url <- 'http://data.gov.tw/iisi/logaccess/2879?dataUrl=http://file.data.gov.tw/event/dataset.xml&ndctype=XML&ndcnid=8693'
x <- xmlParse(url, encoding = "utf8") # 以 xmlParse 解析 XML 檔案
xmlfiles <- xmlRoot(x) # 將 root 設定到 content 層級（一個偷吃步的做法）
y <- xmlToDataFrame(xmlfiles) # 轉換成 dataframe
colnames(y) <- c('資料集提供機關','資料集名稱','瀏覽次數','下載次數','資料集評分')

# (3) json files
library(jsonlite)  # PS: 還有其他套件
url <- 'http://data.gov.tw/iisi/logaccess/2878?dataUrl=http://file.data.gov.tw/event/dataset.json&ndctype=JSON&ndcnid=8693'
y <- fromJSON(url, flatten = TRUE)
y <- as.data.frame(y$Records)

# 將整理完成的檔案存成 CSV
write.csv(file = 'open.csv', y, fileEncoding = 'big5')