#**************************************************************************************************
#
#                 Prevendo a inadimplência de clientes com Machine Learning e Power BI
#                                  
#                                 Produzido no curso da Datascience Academy  
#
#**************************************************************************************************


#Definindo a pasta de trabalho

setwd("C:/Users/User/OneDrive/Documentos/Curso_Power_BI/MachinheLeraningCap15")
getwd()


#Instalando pacotes
install.packages("Amelia")
install.packages("caret")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("reshape")
install.packages("randomForest")
install.packages("e1071")

#carregando pacotes
library(Amelia)
library(ggplot2)
library(caret)
library(reshape)
library(randomForest)
library(dplyr)
library(e1071)


#carregando dataset
#Fonte: https://archive.ics.uci.edu/ml/datasets/default+of+credit+card+clients

dados_clientes <- read.csv("dados/dataset.csv")

#Visualizando os dados e sua estrutura

View(dados_clientes)
str(dados_clientes)
summary(dados_clientes)

################### Análise Exploratória, Limpeza e Transformação###################

#Removendo a primeira coluna ID

dados_clientes$ID <- NULL
dim(dados_clientes)
View(dados_clientes)

#Renomeando coluna de classificação
colnames(dados_clientes)
colnames(dados_clientes)[24] <- "inadimplente"
colnames(dados_clientes)
View(dados_clientes)

#Verificando valores ausente e removendo do dataset
sapply(dados_clientes, function(x) sum(is.na(x)))
missmap(dados_clientes, main = "Valores observados")
dados_clientes <- na.omit(dados_clientes)


#######convertendo as variaveis genero, escolaridade e estado civil e idade para fatores (categorica)#########


#renomenando colunas categoricas

colnames(dados_clientes)[2] <- "Genero"
colnames(dados_clientes)[3] <- "Escolaridade"  
colnames(dados_clientes)[4] <-  "Estado_Civil"
colnames(dados_clientes)[5] <-  "Idade"
colnames(dados_clientes)


# Genero
View(dados_clientes$Genero)
str(dados_clientes$Genero)
summary(dados_clientes$Genero)

dados_clientes$Genero <- cut(dados_clientes$Genero, c(0,1,2), labels = c("Masculino", "Feminino"))


# Escolaridade

dados_clientes$Escolaridade <- cut(dados_clientes$Escolaridade, c(0,1,2,3,4),
                                   labels = c("Pos-Graduado", "Graduado", "Ensino Medio", "Outros"))


View(dados_clientes$Escolaridade)
str(dados_clientes$Escolaridade)
summary(dados_clientes$Escolaridade)


#Estado Civil

dados_clientes$Estado_Civil <- cut(dados_clientes$Estado_Civil, c(0,1,2,3,4),
                                   labels = c("Desconhecido", "Casado", "Solteiro", "Outro"))


View(dados_clientes$Estado_Civil)
str(dados_clientes$Estado_Civil)
summary(dados_clientes$Estado_Civil)


#Convertendo idade para faixa etaria

str(dados_clientes$Idade)


dados_clientes$Idade <- cut(dados_clientes$Idade, c(0,30,50,100),
                                   labels = c("Jovem", "Adulto", "Idoso"))


summary(dados_clientes)
str(dados_clientes$Idade)


#convertendo as variaveis de pagamento para categorica
dados_clientes$PAY_0 <- as.factor(dados_clientes$PAY_0)
dados_clientes$PAY_2 <- as.factor(dados_clientes$PAY_0)
dados_clientes$PAY_3 <- as.factor(dados_clientes$PAY_0)
dados_clientes$PAY_4 <- as.factor(dados_clientes$PAY_0)
dados_clientes$PAY_5 <- as.factor(dados_clientes$PAY_0)
dados_clientes$PAY_6 <- as.factor(dados_clientes$PAY_6)


#visualização dos dados
str(dados_clientes)
sapply(dados_clientes, function(x) sum(is.na(x)))
dados_clientes <- na.omit(dados_clientes)
missmap(dados_clientes, main = "Valores observados")
dim(dados_clientes)

