# Murrell, Paul (2011), R Graphics, 2nd Edition.

## Chapter 5: {ggplot2}: qplot() & ggplot()

if (!require(ggplot2)) {install.packages('ggplot2'); library(ggplot2)}


### qplot()
qplot(temperature, pressure, data = pressure)

qplot(temperature, pressure, 
      data = pressure,
      main = 'Vapor Pressure of Mercury',
      geom = c('point', 'line'),
      lty = I('dashed'))

### ggplot(): data + aes() + geom_
ggplot(pressure, aes(x = temperature, y = pressure, colour = 'red')) +
  geom_point(colour = 'blue') +
  geom_line(colour = 'green') +
  geom_smooth()

ggplot(pressure, aes(x = temperature, y = pressure)) +
  geom_point() +
  geom_line() +
  geom_smooth()

ggplot(pressure) + 
  aes(x = temperature, y = pressure) +
  geom_point() +
  geom_line() +
  geom_smooth()


str(mtcars)

ggplot(mtcars) +
  aes(x = disp, y = mpg) +
  geom_point()

ggplot(mtcars) +
  aes(x = disp, y = mpg, label = gear) +
  geom_text()

ggplot(mtcars) +
  geom_text(aes(x = disp, y = mpg, label = gear))


lmcoef <- coef(lm(mpg~disp, mtcars))

ggplot(mtcars) +
  aes(x = disp, y = mpg) +
  geom_point() +
  geom_abline(intercept = lmcoef[1], slope = lmcoef[2])
