############################################################## 
###                                                                           
###   Data Science Specialization Capstone Project  
###   Word prediction
###                                                                                   
###   Dusan Randjelovic (https://rs.linkedin.com/in/duxan)           
###   github: https://github.com/duxan/..... 
###                                                                         
############################################################## 

library(quanteda)
library(slam)
library(stringr)
library(parallel)
library(doParallel)
options(mc.cores=4)

handle <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
if (!file.exists("Coursera-SwiftKey/final/en_US/en_US.blogs.txt")){
  download.file(url=handle, "Coursera-SwiftKey.zip", mode="wb")
  unzip("Coursera-SwiftKey.zip")
}

cat("Reading the dataset\n")

#blogs <- readLines("Coursera-SwiftKey/final/en_US/en_US.blogs.txt", encoding="UTF-8", skipNul=T)
news <- readLines("Coursera-SwiftKey/final/en_US/en_US.news.txt", encoding="UTF-8", skipNul=T)
twitter <- readLines("Coursera-SwiftKey/final/en_US/en_US.twitter.txt", encoding="UTF-8", skipNul=T)

#blogs <- iconv(blogs,to="utf-8-mac")
#blogs <- blogs[!is.na(blogs)]

news <- iconv(news,to="utf-8-mac")
news <- news[!is.na(news)]

twitter <- iconv(twitter,to="utf-8-mac")
twitter <- twitter[!is.na(twitter)]


cat("Done.\n")

cat("Building and cleaning the corpus\n")
#finalCorpus <- base::sample(c(blogs, news, twitter), length(c(blogs, news, twitter))*1)
finalCorpus <- base::sample(c(news, twitter), length(c(news, twitter))*0.025)

delim = " \\r\\n\\t.,;:\"()?!"

profanity <- as.character(read.table("./data/profanityfilter.txt", header = F)$V1)
singletons <- c("t", "s", "m", "u", "d", "p", "dm", "rt", "ht", "mt", "g", "w", "c", "f")
ignored.features <- append(profanity, singletons)

finalCorpus <- tolower(finalCorpus)

# Generic function for parallelizing any task (when possible)
parallelizeTask <- function(task, ...) {
  # Calculate the number of cores
  ncores <- detectCores() # - 1
  # Initiate cluster
  cl <- makeCluster(ncores)
  registerDoParallel(cl)
  #print("Starting task")
  r <- task(...)
  #print("Task done")
  stopCluster(cl)
  r
}

ngramTokenizer <- function(ngramCount) {
  cat(paste0("Building TDM for ", ngramCount, "-gram\n"))
  dfm <- dfm(finalCorpus, what="word", removeNumbers = T, 
             removePunct = T, removeSymbols = T, removeSeparators = T, 
             removeTwitter = T, removeHyphens = T, removeURL = T, 
             ngrams=ngramCount, concatenator=" ", toLower=F, 
             ignoredFeatures=c(stopwords("english"), ignored.features), verbose=T)

  tdm <- tm::as.TermDocumentMatrix(convert(dfm, to="tm"))
  rm(dfm)
  cat("Preparing TDM as data.frame\n")
  n.gram <- data.frame(row_sums(tdm))
  rm(tdm)
  n.gram$term <- rownames(n.gram)
  rownames(n.gram) <- NULL
  words <- str_split_fixed(n.gram$term, " ", ngramCount) 
  n.gram <- cbind(words, n.gram[ ,1])
  rm(words)
  return(n.gram)
}

subsetTDM <- function(tdm, thresh){
  tdm <- as.data.frame(tdm)
  tdm$frequency <- as.integer(as.character(tdm$frequency))
  tdm <- tdm[order(-tdm$frequency),] 
  tdm <- tdm[tdm$frequency > thresh,]
  return(tdm)
}

bigram <- parallelizeTask(ngramTokenizer, 2)
colnames(bigram) <- c("unigram", "bigram", "frequency")
#bigram <- subsetTDM(bigram, 0)
cat("Saving bigram\n")
saveRDS(bigram, file = "2gram.RData")
rm(bigram)
cat("Done.\n")

trigram <- parallelizeTask(ngramTokenizer, 3)
colnames(trigram) <- c("unigram", "bigram", "trigram", "frequency")
#trigram <- subsetTDM(trigram, 0)
cat("Saving trigram\n")
saveRDS(trigram, file = "3gram.RData")
rm(trigram)
cat("Done.\n")

quadgram <- parallelizeTask(ngramTokenizer, 4)
colnames(quadgram) <- c("unigram", "bigram", "trigram", "quadgram", "frequency")
#quadgram <- subsetTDM(quadgram, 0)
cat("Saving quadgram\n")
saveRDS(quadgram, file = "4gram.RData")
rm(quadgram)
cat("Done.\n")

cat("\n=== DONE ===\n")

