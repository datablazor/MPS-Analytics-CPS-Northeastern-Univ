library(data.table)
#install.packages("bit64")
library("bit64")

# Sentiment analysis
library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)
library(factoextra) # clustering algorithms & visualization

# Read file
apple_pre <- fread("/Users/kass/Downloads/Northeastern/ALY6040-DataMingingApplications_Spring_B_2020_Thu_82141/Coursework/Week4/apple.csv", header = T, stringsAsFactors = F)
str(apple_pre)

# Build corpus
library(tm)
# Convert a character vector between encodings - we need 'utf-8-mac' encoding to be the output encoding
tweets_pre <- iconv(apple_pre$text, to = "utf-8-mac"); class(tweets_pre)
corpus <- iconv(apple_pre$text, to = "utf-8-mac"); class(corpus)
head(corpus)
# Convert the corpora (collection of documents) to a tm based virtual S3 class
corpus <- Corpus(VectorSource(corpus)); class(corpus)
inspect(corpus[1:5])

# Clean text
getTransformations()

corpus <- tm_map(corpus, tolower)
inspect(corpus[1:5])

options(warn=-1)
#options(warn=-0)

corpus <- tm_map(corpus, removePunctuation)
inspect(corpus[1:5])

corpus <- tm_map(corpus, removeNumbers)
inspect(corpus[1:5])

stopwords('english')
cleanset <- tm_map(corpus, removeWords, stopwords('english'))
inspect(cleanset[1:10])

removeURL <- function(x) gsub('http[[:alnum:]]*', '', x)
cleanset <- tm_map(cleanset, content_transformer(removeURL))
inspect(cleanset[1:5])

?tm_map
?gsub

cleanset <- tm_map(cleanset, stripWhitespace)
inspect(cleanset[1:5])

class(cleanset)

# Term document matrix
tdm <- TermDocumentMatrix(cleanset)
tdm
tdm <- as.matrix(tdm)
tdm[1:10, 1:20]

# Bar plot
w <- sort(rowSums(tdm), decreasing = T);head(w)
w <- subset(w, w>=20)
barplot(w,
        las = 1,
        col = rainbow(50))

cleanset <- tm_map(cleanset, removeWords, c('aapl', 'apple', "appleinc", "‘apple"))

w[grepl("stock", names(w))]
cleanset <- tm_map(cleanset, gsub, 
                   pattern = 'stocks', 
                   replacement = 'stock')
inspect(cleanset[1:5])

tdm <- TermDocumentMatrix(cleanset)

# Sparsity - ratio of 0 elements in the TDM

tdm_DTM=DocumentTermMatrix(cleanset)
#tdm_rm_sparse_70 = removeSparseTerms(tdm_DTM,sparse=0.7)
tdm_DTM
View(inspect(tdm_DTM[15:25, 1:100]))

tdm
tdm <- as.matrix(tdm)
tdm[1:10, 1:20]
# Bar plot
w <- sort(rowSums(tdm), decreasing = T);head(w)
w <- subset(w, w>=25)
barplot(w,
        las = 2,
        col = rainbow(100))

# Word cloud
library(wordcloud)
w <- sort(rowSums(tdm), decreasing = TRUE)
set.seed(232)
wordcloud(words = names(w),
          freq = w,
          min.freq = 50)

wordcloud(words = names(w),
          freq = w,
          max.words = 100,
          random.order = F,
          min.freq = 5,
          colors = brewer.pal(8, 'Dark2'),
          scale = c(3, 0.3),
          rot.per = 0.7)

library(wordcloud2)
w <- data.frame(names(w), w)
colnames(w) <- c('word', 'freq')
wordcloud2(w,
           size = 0.7,
           shape = 'triangle',
           rotateRatio = 0.5,
           minSize = 1)

wordcloud2(w,
           size = 0.4,
           shape = 'circle',
           rotateRatio = 0.5,
           minSize = 1)

# Obtain sentiment scores
get_nrc_sentiment(tweets_pre[3])
get_nrc_sentiment('break')

s1 <- get_nrc_sentiment(tweets_pre)
head(s1)
tweets_pre[4]

# Bar plot
p1 = barplot(colSums(s1),
        las = 2,
        col = rainbow(10),
        ylab = 'Count',
        main = 'Sentiment Scores for Apple Tweets - Pre Earning Statements')


# Read file
apple_post <- fread("/Users/kass/Downloads/Northeastern/ALY6040-DataMingingApplications_Spring_B_2020_Thu_82141/Coursework/Week4/apple2.csv", header = T, stringsAsFactors = F)
tweets_post <- iconv(apple_post$text, to = 'utf-8-mac')

# Obtain sentiment scores
s2 <- get_nrc_sentiment(tweets_post)
head(s2)
tweets_post[5]
get_nrc_sentiment("focus")
get_nrc_sentiment("hope")
get_nrc_sentiment(tweets_post[5])

# Bar plot
p2 = barplot(colSums(s2),
        las = 2,
        col = rainbow(10),
        ylab = 'Count',
        main = 'Sentiment Scores for Apple Tweets - Post Earning Statements')

both = data.frame(pre_sentiment = colSums(s1), post_sentiment = colSums(s2))
both$sentiment = row.names(both)
both.melt = melt(both[,c('sentiment','pre_sentiment','post_sentiment')],id.vars = 1)
ggplot(both.melt,aes(x = sentiment,y = value)) + 
        geom_bar(aes(fill = variable),stat = "identity",position = "dodge") 

## Clustering ##

#1. Based on Terms
#2. Based on Sentiments - Class work

# remove sparse terms
tdm <- TermDocumentMatrix(cleanset)
as.matrix(tdm[1:10,1:20])
tdm2 <- removeSparseTerms(tdm, sparse = 0.95)
m2 <- as.matrix(tdm2)
m2[1:10,1:20]
# cluster on "terms"
scale_m2 <- scale(m2); m2[1:20,1:20]

# distMatrix <- dist(scale_m2)
# fit <- hclust(distMatrix, method = "ward.D")
# plot(fit)
# rect.hclust(fit, k = 6) # cut tree into 6 clusters 

m3 <- t(m2) # transpose the matrix to cluster documents (tweets)
m3[,1:10]
set.seed(122) # set a fixed random seed
k <- 6 # number of clusters
kmeansResult <- kmeans(m3, k)
kmeansResult
round(kmeansResult$centers, digits = 3) # cluster centers
fviz_cluster(kmeansResult, data = m3)

## Stemming
stem_doc = stemDocument(c("complicated", "complication", "complicatedly")); stem_doc
comp_dict = c("complicate")
complete_text = stemCompletion(stem_doc, dictionary = comp_dict); complete_text

stem_doc = stemDocument(c("computational", "computers", "computation")); stem_doc
comp_dict = c("computer")
complete_text = stemCompletion(stem_doc, dictionary = comp_dict); complete_text

