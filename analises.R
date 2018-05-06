###########################
### Trabalho Sarah
# Análises
# script: Neylson Crepalde
###########################

library(readxl)
library(readr)
library(dplyr)
library(tm)
library(wordcloud)
library(magrittr)
library(igraph)
library(ggplot2)
library(forcats)

dados = read_xlsx("Dados para análise.xlsx")
boi = read_csv("boi_werneck_comentarios_facebook.csv")
piu = read_csv("piu_braziliano_comentarios_facebook.csv")
rancho = read_csv("rancho_fundo_comentarios_facebook.csv")
republica = read_csv("republica_esbornia_comentarios_facebook.csv")

boi = boi %>% select(plataforma, pagina, texto)
piu = piu %>% select(plataforma, pagina, texto)
rancho = rancho %>% select(plataforma, pagina, texto)
republica = republica %>% select(plataforma, pagina, texto)

completo = rbind(dados, boi, piu, rancho, republica)

texto = completo$texto %>% tolower %>% removePunctuation %>% 
  removeWords(stopwords("pt"))

# Nuvem de palavras
pal = RColorBrewer::brewer.pal(9, "Blues")[6:9]
wordcloud(enc2native(texto), min.freq = 3, max.words = 100, random.order = F, colors = pal)

# Nuvem de palavras do rancho fundo
text_rancho = completo$texto[completo$pagina == "Rancho Fundo"] %>% tolower %>% removePunctuation %>% 
  removeWords(stopwords("pt"))
wordcloud(enc2native(text_rancho), min.freq = 3, max.words = 100, random.order = F, colors = pal)

# Nuvem de palavras do Zé Pileque
text_ze = completo$texto[completo$pagina == "Zé Pileque Botequim"] %>% tolower %>% removePunctuation %>% 
  removeWords(stopwords("pt"))
wordcloud(enc2native(text_ze), min.freq = 3, max.words = 100, random.order = F, colors = pal)

# Nuvem de palavras do Piu Braziliano
text_piu = completo$texto[completo$pagina == "Piu Braziliano"] %>% tolower %>% removePunctuation %>% 
  removeWords(stopwords("pt"))
wordcloud(enc2native(text_piu), min.freq = 3, max.words = 100, random.order = F, colors = pal)

# Nuvem de palavras do Boi Werneck
text_boi = completo$texto[completo$pagina == "Boi Werneck"] %>% tolower %>% removePunctuation %>% 
  removeWords(stopwords("pt"))
wordcloud(enc2native(text_boi), min.freq = 3, max.words = 100, random.order = F, colors = pal)


#-------------------------------------
# Análise de clusterização ou Cluster Analysis
# (Análise de conteúdo)

#Geral
corpus <- Corpus(VectorSource(texto))
tdm <- TermDocumentMatrix(corpus)
tdm <- removeSparseTerms(tdm, sparse = 0.97)
df <- as.data.frame(as.matrix(tdm))
dim(df)
df.scale <- scale(df)
d <- dist(df.scale, method = "euclidean")
fit.ward2 <- hclust(d, method = "ward.D2")
plot(fit.ward2, main = "Geral")


#Rancho
corpus <- Corpus(VectorSource(text_rancho))
tdm <- TermDocumentMatrix(corpus)
tdm <- removeSparseTerms(tdm, sparse = 0.96)
df <- as.data.frame(as.matrix(tdm))
dim(df)
df.scale <- scale(df)
d <- dist(df.scale, method = "euclidean")
fit.ward2 <- hclust(d, method = "ward.D2")
plot(fit.ward2, main = "Rancho Fundo")


#Ze
corpus <- Corpus(VectorSource(text_ze))
tdm <- TermDocumentMatrix(corpus)
tdm <- removeSparseTerms(tdm, sparse = 0.945)
df <- as.data.frame(as.matrix(tdm))
dim(df)
df.scale <- scale(df)
d <- dist(df.scale, method = "euclidean")
fit.ward2 <- hclust(d, method = "ward.D2")
plot(fit.ward2, main = "Zé Pileque Botequim")


#Piu Braziliano
corpus <- Corpus(VectorSource(text_piu))
tdm <- TermDocumentMatrix(corpus)
tdm <- removeSparseTerms(tdm, sparse = 0.96)
df <- as.data.frame(as.matrix(tdm))
dim(df)
df.scale <- scale(df)
d <- dist(df.scale, method = "euclidean")
fit.ward2 <- hclust(d, method = "ward.D2")
plot(fit.ward2, main = "Piu Braziliano")

#Boi Werneck
corpus <- Corpus(VectorSource(text_boi))
tdm <- TermDocumentMatrix(corpus)
tdm <- removeSparseTerms(tdm, sparse = 0.985)
df <- as.data.frame(as.matrix(tdm))
dim(df)
df.scale <- scale(df)
d <- dist(df.scale, method = "euclidean")
fit.ward2 <- hclust(d, method = "ward.D2")
plot(fit.ward2, main = "Boi Werneck")


# Redes semânticas
g <- graph_from_incidence_matrix(as.matrix(tdm))
p = bipartite_projection(g, which = "FALSE")
V(p)$shape = "none"
deg = degree(p)

plot(p, vertex.label.cex=deg/30, edge.width=(E(p)$weight)/10, 
     edge.color=adjustcolor("grey60", .5),
     vertex.label.color=adjustcolor("red", .7))
title("Zé Pileque")


# Contando os comentários de cada bar
completo %>% group_by(pagina) %>% summarise(n = n()) %>% 
  ggplot(aes(x = fct_reorder(pagina, n), y = n, label = n)) + 
  geom_col(fill = adjustcolor("blue", .7)) + coord_flip() + 
  ylim(0, 240) +
  labs(title = "Críticas coletadas", x = "Estabelecimento", y = "") + 
  theme_bw(base_size = 14) + 
  theme(legend.position = "none") +
  geom_text(size = 5, hjust = -.5)

