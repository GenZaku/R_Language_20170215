## {magrittr}
#   https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html

rm(list = ls())

### 傳統寫法
str(mtcars)  # profiling
res <- subset(mtcars, hp > 100)  # subseting
str(res)
res <- aggregate(. ~ cyl, data = res, FUN = mean)  # aggregation
res <- round(res, 2)    # formatting
res <- transform(res, kpl = mpg * 0.4251)  # transformation
print(res)


### {magrittr}: pipeline operator %>%
#   https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html

if (!require(magrittr)) install.packages(magrittr)
library(magrittr)

res1 <- 
  mtcars %>%
  subset(hp > 100) %>%
  aggregate(. ~ cyl, data = ., FUN = . %>% mean %>% round(2)) %>%
  transform(kpl = mpg %>% multiply_by(0.4251)) %>%
  print

