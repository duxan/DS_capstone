############################################################## 
###                                                                           
###   Data Science Specialization Capstone Project  
###   Word prediction
###                                                                                   
###   Dusan Randjelovic (https://rs.linkedin.com/in/duxan)           
###   github: https://github.com/duxan/..... 
###                                                                         
############################################################## 


nextWordPrediction <- function(textInput, n=1){
  
  wordCount <- length(textInput)
  if (wordCount>=3) {
    textInput <- textInput[(wordCount-2):wordCount] 
  } else if(wordCount==2) {
    textInput <- c(NA,textInput)   
  } else {
    textInput <- c(NA,NA,textInput)
  }
  
  wordPrediction <- as.character(final4Data[final4Data$unigram==textInput[1] & 
                               final4Data$bigram==textInput[2] & 
                               final4Data$trigram==textInput[3],][1:n,"quadgram"])
  if(anyNA(wordPrediction)) {
    wordPrediction <- as.character(final3Data[final3Data$unigram==textInput[2] & 
                                              final3Data$bigram==textInput[3],][1:n,"trigram"])
    if(anyNA(wordPrediction)) {
      wordPrediction <- as.character(final2Data[final2Data$unigram==textInput[3],][1:3,"bigram"])
    }
  }
  
  return(wordPrediction)
}