#Lab Linear Regress
install.packages("ISLR")
library(MASS)
library(ISLR)
# the Mass library contains the Boston data set, which records medv for 506 neighborhoods around Boston
# We will seek to predict medv using 13 predictors such as rm (average number of rooms per house)
fix(Boston)
names(Boston)
?Boston  # to find more info regarding the Boston data set
# We will start by using the lm() function to fit a simple linear regression model, with medv as the
# response and lstat as the predictor. The basic syntax is lm(y~x,data), where y is the response,
# x is the predictor, and data is the data set in which these two variables are kept
lm.fit = lm(medv~lstat, data=Boston)
attach(Boston)
lm.fit = lm(medv~lstat)
lm.fit
summary(lm.fit) # get p value and stastistics data for this linear regression
names(lm.fit)
coef(lm.fit)
confint(lm.fit)
predict(lm.fit, data.frame(lstat=c(5,10,15)), interval = "confidence")
predict(lm.fit, data.frame(lstat=c(5,10,15)), interval = "prediction")
# We will not plot medv and lstat along with the least squares regression line using the plot() and abline() functions
plot(lstat,medv)
abline(lm.fit) # the abline() function can be used to draw any line, not just the least squares regression line.
abline(lm.fit, lwd=3, col="red")
plot(lstat, medv, col = "red")
plot(lstat, medv, pch = 20)
plot(lstat, medv, pch = "+")
plot(1:20, 1:20, pch = 1:20)
# Next we examine some diagnostic plots, several of which were discussed in Section 3.3.3. Four diagnostic 
#plots are automatically produced by applying the plot() function directly to the output from lm().
#It is often convenient to view all four plots together. We can achieve this by using par() function.
# par(mfrow=c(2,2)) divides the plotting region into a 2x2 grid of panels.
par(mfrow= c(2,2))
plot(lm.fit)
#Alternatively, we can compute the residuals from a linear regression fit using the residuals() function
plot(predict(lm.fit), residuals (lm.fit))
plot(predict(lm.fit), rstudent(lm.fit))
# On the basis of the residual plots, there is some evidence of non-linearity. Leverage statistics can be computed for any number of predictors using the hatvalues() function
plot(hatvalues(lm.fit))
which.max(hatvalues(lm.fit)) #identifies the index of the largest element of a vector. It tells us which obervation has the largest leverage statistic

# Multiple Linear Regression

'''The syntax lm(y ~ x1+x2+x3) is used to fit a model with three predictors, x1, x2, and x3. The summary()
function now outputs the regression coefficients for all the predictors'''

lm.fit = lm(medv~lstat+age, data=Boston)
summary(lm.fit)

# The Boston data set contains 13 variables, and it would be cumbersome to have to type all of these in order to perform a regression using all of the predictors
lm.fit = lm(medv~., data = Boston)
summary(lm.fit)
summary(lm.fit)$sigma  #gives us the RSE
summary(lm.fit)$r.sq # gives us R squared

#What if we would like to perform a regression using all of the variables but one?
lm.fit1 = lm(medv~.-age, data=Boston)
summary(lm.fit1)
# Alternatively, the update() function can be used
lm.fit1=update(lm.fit, ~.-age)
# Interaction Terms
'''It is easy to include interaction terms in a linear model using the lm() function. The syntax 
lstat:black tells R to include an interaction term between lstat and black. The syntax lstat*age
simultaneously includes lstat, age, and the interaction term lstatxage as predictors'
summary(lm(medv~lstat*age, data = Boston))
# Non-linear Transformations of the Predictors
lm.fit2 = lm(medv~lstat+I(lstat^2))
summary(lm.fit2)
'''The near-zero -value associated with the quadratic term suggests that it leads to an imporoved model.
We use the anova() function to further quantify the extent to which the quadratic fit is superior to the linear fit'

lm.fit = lm(medv~ lstat)
anova(lmv=lm.fit, lm.fit2)
par(mfrow=c(2,2))
plot(lm.fit2)
lm.fit5 = lm(medv~poly(lstat,5))
summary(lm.fit5)
summary(lm(medv~log(rm),data=Boston))

# Qualitative Predictors

fix(Carseats)
names(Carseats)
lm.fit = lm(Sales~.+Income:Advertising+Price:Age, data=Carseats)
summary(lm.fit)
'The contrasts() function returns the coding that R uses for the dummy variables.
attach(Carseats)
contrasts(ShelveLoc)

# Writing Functions

LoadLibraries()
