############################################################## 
###                                                                           
###   Data Science Specialization Capstone Project  
###   Word prediction
###                                                                                   
###   Dusan Randjelovic (https://rs.linkedin.com/in/duxan)           
###   github: https://github.com/duxan/..... 
###                                                                         
############################################################## 

dataCleaner<-function(text){
  
  cleanText <- tolower(text)
  cleanText <- removePunctuation(cleanText)
  cleanText <- removeNumbers(cleanText)
  cleanText <- str_replace_all(cleanText, "[^[:alnum:]]", " ")
  cleanText <- stripWhitespace(cleanText)
  cleanText <- removeWords(cleanText, stopwords("english"))
  
  return(cleanText)
}

cleanInput <- function(text){
  
  textInput <- dataCleaner(text)
  textInput <- txt.to.words.ext(textInput, 
                                language="English.all", 
                                preserve.case = F)
  return(textInput)
}