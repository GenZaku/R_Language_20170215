# Plotting Time Series in R using Yahoo Finance data
#   https://www.r-bloggers.com/plotting-time-series-in-r-using-yahoo-finance-data/

# Time Series Plotting
if (!require(ggplot2)) install.packages('ggplot2')
library(ggplot2)
if (!require(xts)) install.packages('xts')
library(xts)
if (!require(dygraphs)) install.packages('dygraphs')
library(dygraphs)

# Get IBM and Linkedin stock data from Yahoo Finance
ibm_url <- "http://real-chart.finance.yahoo.com/table.csv?s=IBM&a=07&b=24&c=2010&d=07&e=24&f=2017&g=d&ignore=.csv"
lnkd_url <- "http://real-chart.finance.yahoo.com/table.csv?s=LNKD&a=07&b=24&c=2010&d=07&e=24&f=2017&g=d&ignore=.csv"

yahoo.read <- function(url){
  dat <- read.table(url, header=TRUE,sep=",")
  df <- dat[,c(1,5)]
  df$Date <- as.Date(as.character(df$Date))
  return(df)}

ibm  <- yahoo.read(ibm_url)
lnkd <- yahoo.read(lnkd_url)

## {ggplot}
ggplot(ibm,aes(Date,Close)) + 
  geom_line(aes(color="ibm")) +
  geom_line(data=lnkd,aes(color="lnkd")) +
  labs(color="Legend") +
  scale_colour_manual("", breaks = c("ibm", "lnkd"),
                      values = c("blue", "brown")) +
  ggtitle("Closing Stock Prices: IBM & Linkedin") + 
  theme(plot.title = element_text(lineheight=.7, face="bold"))

## {dygrpah}
# Plot with the htmlwidget dygraphs
# dygraph() needs xts time series objects
ibm_xts <- xts(ibm$Close, order.by=ibm$Date, frequency=365)
lnkd_xts <- xts(lnkd$Close, order.by=lnkd$Date, frequency=365)

stocks <- cbind(ibm_xts, lnkd_xts)

dygraph(stocks, ylab="Close", 
        main="IBM and Linkedin Closing Stock Prices") %>%
  dySeries("..1", label="IBM") %>%
  dySeries("..2", label="LNKD") %>%
  dyOptions(colors = c("blue","brown")) %>%
  dyRangeSelector()