#integracao via url para dataframe em memória
wines <- read.table(
  'http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv',
  sep=';',
  header = TRUE
)

#analise exploratoria para conhecer a estrutura
head(wines)
dim(wines)
str(wines)
summary(wines)

#verificando presenca de valores indisponiveis
colSums(is.na(wines))

#verificando outliers para cada coluna
boxplot(wines$fixed.acidity)
boxplot(wines$volatile.acidity)
boxplot(wines$citric.acid)
boxplot(wines$residual.sugar)
boxplot(wines$chlorides)
boxplot(wines$free.sulfur.dioxide)
boxplot(wines$total.sulfur.dioxide)
boxplot(wines$density)
boxplot(wines$pH)
boxplot(wines$sulphates)
boxplot(wines$alcohol)
boxplot(wines$quality)
