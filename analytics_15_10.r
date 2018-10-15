# Se as bibliotecas necessárias não estiveram instaladas, instale

if (!"readr" %in% installed.packages()) install.packages("readr")
if (!"dplyr" %in% installed.packages()) install.packages("dplyr")
if (!"ggplot2" %in% installed.packages()) install.packages("ggplot2")
if (!"haven" %in% installed.packages()) install.packages("haven")
install.packages("descr")

# Carregando as bibliotecas necessárias
library(readr)
library(dplyr)
library(ggplot2)
library(haven)
library(descr) # estatisticas descritivas

data("diamonds")
dim(diamonds)
names(diamonds)
summary(diamonds$price) # indica  as estasticas sobre o preço dos diamantes
diamonds$expensive = ifelse (diamonds$price >
                               mean (diamonds$price),
                             1,0) # criação da variavel expensive
freq(diamonds$expensive,plot = F)
# 64% dos diamantes não são caros - 0 não sao caros e 1 são caros

# tabela cruzada com corte com caro
t = table(diamonds$cut, diamonds$expensive)
t 
# corte na linha e caro ou não na coluna
prop.table(t,2)*100
# a mesma informaçaõ, interssao das variaveis, mas em porcentagem
# 21,68% do diamantes muito bom não são caros
# 3% dos diamantes são caros e tem o corte fair (justo)

# teste qui-quadrado - verifica se há associação entre o corte e ser caro ou não. Se é estastisticamente valido
chisq.test(t)
# 4 graus de liberdade
# qui quadrado 976.8
# p valor < 2.2e-16 - Rejeito a hipotese nula e aceito H1 - Que é corte e ser caro ou não tem relação

## Rodando uma regressão logistica
## y = expensive
## x = carat
# corte e ser caro tem associação

# glm = modelos lineares
reg = glm(expensive ~  carat,
          data = diamonds,
          family = binomial(link= "logit"))
summary(reg)
# y = expensive
# x = carat
# não da para fazer mqo na regressao logistica
# estamos estimando razao entre probabilidades
# quanto mais pesado tem mais chance de serem mais caros

# exercicio
#rodar a regressão com as alterações
# y = expensive
# x = carat + cut 
