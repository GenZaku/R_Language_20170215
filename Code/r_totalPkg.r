# 10,000 CRAN Packages
#   https://www.rstudio.com/rviews/2017/01/06/10000-cran-packages/

# Function to read range of cranberries new package files
# and count number of new packages for the months in question
# The function takes a starting year and ending year as inputs
# and assumes each year has a full 12 months of data.


### The following function pulls information from CRANberries and returns a vector containing the number of new packages submitted to CRAN in a specified time period.
num_new <- function(start,end){
  # start and end must be years between 2008 and 2016 with start <= end
  index <- start - (start -1)
  y_span <- start:end
  m_span <- length(y_span) * 12
  
  num_new_pkgs <- vector(mode="integer", length=m_span)
  for (year in y_span){
    two_digits <- c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
    for (month in two_digits) {
      try({  # http://stackoverflow.com/questions/12193779/how-to-write-trycatch-in-r
        url <- paste("http://dirk.eddelbuettel.com/cranberries/", year, "/", month, sep="")
          # ex. http://dirk.eddelbuettel.com/cranberries/2016/01
        raw.data <- readLines(url)
        num_new_pkgs[index] <- length(grep("New package", raw.data, value=TRUE))
        index <- index + 1
      })
    }
  }
  return(num_new_pkgs)
}

results <- num_new(2008, 2017)  # http://stackoverflow.com/questions/12193779/how-to-write-trycatch-in-r


### Let’s plot the data as a time series.

library(ggplot2)

# Build a vector of dates. It is convenient to use the first of the month
time <- seq(as.Date("2008/1/1"),as.Date("2016/12/1"),by="month")

# Build a data frame to plot
pkg_data <- data.frame(time,results)
names(pkg_data) <- c("Month", "New_Pkg")
#head(pkg_data)

p <- ggplot(pkg_data, aes(x=Month, y=New_Pkg)) +
  geom_line() +
  geom_smooth(method="loess") 
p


### Forecast the expected number of new packages for the next several months.

library(forecast)
forecast(results)
