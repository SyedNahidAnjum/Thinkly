# Libraries and options ####
rm(list=ls(all=TRUE))
library(dplyr)
library(quanteda)
library(stringr)
library(tm)
library(readr)
library(caTools)
library(tidyr)

source("PredictWordAlgo.R")
if (!file.exists("Coursera-SwiftKey.zip")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip",
                destfile = "Coursera-SwiftKey.zip", method = "curl")
  unzip("Coursera-SwiftKey.zip")
}


# Read and prepare data ####

# Read in data

dBlog <- readLines("./en_US.blogs.txt", encoding = "UTF-8", skipNul = TRUE)
news<-readLines(con=file("final//en_US//en_US.news.txt", open="rb"), encoding="UTF-8")
# remove the "SUB" non-ASCII character
dNews<-gsub("\032","",news)
dTwitter <- readLines("./en_US.twitter.txt", encoding = "UTF-8", skipNul = TRUE)
library(stringi)
# find the number of lines (blogs/news/twitter) in each dataset
length(dBlog); length(dNews); length(dTwitter)
# find the number of words in each file
stri_stats_latex(dBlog)
stri_stats_latex(dNews)
stri_stats_latex(dTwitter)
blog_words<-stri_count_words(dBlog)
news_words<-stri_count_words(dNews)
twitter_words<-stri_count_words(dTwitter)
summary(blog_words)
summary(news_words)
summary(twitter_words)
#(As anticipated, blogs have the longest average length among the three text
#types, with an average of 41.75 words. In contrast, tweets are the shortest,
#averaging just 12.75 words. The mean length of a blog significantly exceeds 
#the median, indicating the presence of some very long blogs that skew the 
#distribution. In fact, 75% of blogs contain 60 words or fewer, while the 
#longest blog reaches a maximum of 6,726 words.)
hist(blog_words[blog_words<100], breaks=10, main="Histogram of Twitter", xlab="Tweet Word Count")
hist(news_words[news_words<100], breaks=10, main="Histogram of Twitter", xlab="Tweet Word Count")

hist(twitter_words, breaks=10, main="Histogram of Twitter", xlab="Tweet Word Count")
saveRDS(dBlog,"dBlog.RData")
saveRDS(dNews,"dNews.RData")
saveRDS(dTwitter,"dTwitter.RData")
rm(dBlog,dNews,dTwitter)

dBlog <- readRDS("dBlog.RData"); dNews <- readRDS("dNews.RData"); dTwitter <- readRDS("dTwitter.RData")


combinedRaw = c(dBlog, dNews, dTwitter)

combinedRaw<-gsub("\\b[A-Z a-z 0-9._ - ]*[@](.*?)[.]{1,3} \\b", "", combinedRaw)

saveRDS(combinedRaw,"combinedRaw.RData")




# Sample and combine data  
set.seed(1220)
n = 1/10
combined = sample(combinedRaw, length(combinedRaw) * n)
rm(combinedRaw)
# Split into train and validation sets
split = sample.split(combined, 0.8)
train = subset(combined, split == T)
valid = subset(combined, split == F)

rm(combined)

# Transfer to quanteda corpus format and segment into sentences (prediction.R)
train = fun.corpus(train)
saveRDS(train,"train.RData")
train<-readRDS("train.RData")
# Tokenize (prediction.R)
# Create a document-feature matrix with unigrams
ngram1 <- VCorpus(VectorSource(train))
# Remove data we do not need 
ngram1 <- tm_map(ngram1, tolower)
ngram1 <- tm_map(ngram1, removePunctuation)
ngram1 <- tm_map(ngram1, removeNumbers)
ngram1 <- tm_map(ngram1, removeWords, stopwords("english"))
# Do stamming
ngram1 <- ngram1(docs, stemDocument)
# Strip whitespaces
ngram1 <- tm_map(ngram1, stripWhitespace)

# Store freqent n-grams in data frames
df <- as.data.frame(as.matrix(docfreq(ngram1)))
names(df)[1] <- "Frequency"
df_sort <- sort(rowSums(df), decreasing = TRUE)
df_unigrams <- data.frame(Term = names(df_sort), Frequency = df_sort)
df_unigrams<-df_unigrams[df_unigrams$Frequency>100,]
saveRDS(df_unigrams,"df_unigrams.RData")
rm(df, df_sort,df_unigrams,ngram1)


ngram2 <- dfm_remove(train, ngrams = 2, concatenator = " ",remove_punct =TRUE,tolower = FALSE,remove = stopwords("english"),remove_twitter = TRUE)
df <- as.data.frame(as.matrix(docfreq(ngram2)))
names(df)[1] <- "Frequency"
df_sort <- sort(rowSums(df), decreasing = TRUE)
df_bigrams <- data.frame(Term = names(df_sort), Frequency = df_sort)
df_bigrams<-df_bigrams %>% separate(Term, c('word1', 'Term'), " ")
df_bigrams<-df_bigrams[df_bigrams$Frequency>10,]
saveRDS(df_bigrams,"df_bigrams.RData")
saveRDS(ngram2,"ngram2.RData")
rm(df, df_sort,df_bigrams,ngram2)

ngram3 <- dfm_remove(train, ngrams = 3, concatenator = " ",remove_punct =TRUE,tolower = FALSE,remove = stopwords("english"),remove_twitter = TRUE)
df <- as.data.frame(as.matrix(docfreq(ngram3)))
names(df)[1] <- "Frequency"
df_sort <- sort(rowSums(df), decreasing = TRUE)
df_trigrams <- data.frame(Term = names(df_sort), Frequency = df_sort)
df_trigrams<-df_trigrams %>% separate(Term, c('word1', 'word2','Term'), " ")
df_trigrams<-df_trigrams[df_trigrams$Frequency>5,]
saveRDS(df_trigrams,"df_trigrams.RData")
saveRDS(ngram3,"ngram3.RData")
rm(df, df_sort,df_trigrams,ngram3)


ngram4 <- dfm_remove(train, ngrams = 4, concatenator = " ",remove_punct =TRUE,tolower = FALSE,remove = stopwords("english"),remove_twitter = TRUE)
df <- as.data.frame(as.matrix(docfreq(ngram4)))
names(df)[1] <- "Frequency"
df_sort <- sort(rowSums(df), decreasing = TRUE)
df_fourgrams <- data.frame(Term = names(df_sort), Frequency = df_sort)
df_fourgrams<-df_fourgrams %>% separate(Term, c('word1', 'word2','word3','Term'), " ")
df_fourgrams<-df_fourgrams[df_fourgrams$Frequency>5,]
saveRDS(df_fourgrams,"df_fourgrams.RData")
saveRDS(ngram4,"ngram4.RData")
rm(df, df_sort,df_fourgrams,ngram4)

ngram5 <- dfm_remove(train, ngrams = 5, concatenator = " ",remove_punct =TRUE,tolower = FALSE,remove = stopwords("english"),remove_twitter = TRUE)
df <- as.data.frame(as.matrix(docfreq(ngram5)))
names(df)[1] <- "Frequency"
df_sort <- sort(rowSums(df), decreasing = TRUE)
df_fivegrams <- data.frame(Term = names(df_sort), Frequency = df_sort)
df_fivegrams<-df_fivegrams %>% separate(Term, c('word1', 'word2','word3','word4','Term'), " ")
df_fivegrams<-df_fivegrams[df_fivegrams$Frequency>2,]
saveRDS(df_fivegrams,"df_fivegrams.RData")
saveRDS(ngram5,"ngram5.RData")
rm(df, df_sort,df_fivegrams,ngram5)
rm(train)

df_unigrams<-readRDS("df_unigrams.RData");
df_bigrams <- readRDS("df_bigrams.RData"); 
df_trigrams <- readRDS("df_trigrams.RData"); 
df_fourgrams <- readRDS("df_fourgrams.RData");
df_fivegrams <- readRDS("df_fivegrams.RData");