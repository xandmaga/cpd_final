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

#Nos procedimentos do processo de transaformação  o que diz respeito à discretização da 
# qualidade (quality) e tomadas as decisões utilizamos  breaks = c(0, 4, 6, 8) e labels = c("bom", "médio", "bom")
qualidade = cut(wines$quality, breaks=c(0,4,6,8), labels = c("bom", "médio", "bom"))

# No processo de normalização da qualidade (quality) seguimos utilizando o método Min/Máx
normalize <- function(x){return ((x - min(x))/(max(x) - min(x)))}
wines$quality_norm <- normalize(wines$quality)

#E normalização da qualidade pelo método Transformação z-score.
wines$scale <- scale(wines$quality)
head(wines$scale)

#Para selecionar os atributos que têm correlação com a qualidade do vinho e portanto 
#reduzirmos o número de atributos que serão utilizados para a construção do modelo de predição, 
#plotamos os gráficos que analisam a linearidade entre todos os atributos e a qualidade
install.packages("tidyr")
library(tidyr)
install.packages("ggplot2")
install.packages("ggExtra")
library(ggplot2)

melt_wine2 <- melt(wines, "quality")
ggplot(melt_wine2, aes(value, quality, color = variable)) +  
  geom_point() + 
  geom_smooth(aes(value,quality, colour=variable), method=lm, se=FALSE)+
  facet_wrap(.~variable, scales = "free")

#Além disso também geramos um sumário de um modelo linear onde utilizamos todas a
#s variáveis para a predições e analisamos os coeficientes gerados pelo modelo para determinar 
#quais eram estatisticamente significantes para a análise:
 
model_linear <- lm(quality ~., data = red_wine)
summary(model_linear)


