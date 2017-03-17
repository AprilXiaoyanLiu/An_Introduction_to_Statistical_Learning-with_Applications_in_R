install.packages("ISLR")
library(ISLR)
names(Smarket)
dim(Smarket)
summary(Smarket)
?(Smarket)
?Smarket
'The cor() function produces a matrix that contains all of the pairwise correlations among the 
predictors in a data set. The first command below gives an error message because the Direction 
varialbe is qualitative.'
cor(Smarket)
cor(Smarket[,-9])
?Smarket
attach(Smarket)
plot(Volume)

# Logistic Regression

'Next, we will fit a logistic regression model in order to predict Direction using Lag1 through Lag5
and Volume. The glm() function fits generalized linear models,'

glm.fit = glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume, family = binomial, data = Smarket)
summary(glm.fit)

'The smallest p-value here is associated with lag1. The negative coefficient for this predictor suggests that 
if the market had a positive return yesterday, then it is less likely to go up today. However, at 
a value of 0.15, the p-value is still relatively large, and so there is no clear evidience of a real 
association between Lag 1 and Direction'

glm.probs = predict(glm.fit, type="response")
glm.probs[1:10]

'The predict() function can be used to predict the probability that the market will go up, given values of
the predictors. The type = response option tells R to output probabilities of the form P(Y=1|x), as opposed to other 
information such as the logit. We know that these values crrespond to the probability of the market
going up, rather than down, because the contrasts() function indicates that R has created a dummy
variable with a 1 for UP.'

contrasts(Direction)
glm.pred = rep("Down", 1250)
glm.pred[glm.probs > .5] = "Up"

'The first command creates a vector of 1,250 Down elements. The second line transforms to Up all of the
elements for which the predicted probability of a market increase exceeds 0.5. Given these predictions, 
the table() function can be used to produce a confusion matrix in order to determine how many obervations
were correctly or incorrectly classified.'

table(glm.pred, Direction)
mean(glm.pred == Direction)

