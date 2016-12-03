############################################################## 
###                                                                           
###   Data Science Specialization Capstone Project  
###   Word prediction
###                                                                                   
###   Dusan Randjelovic (https://rs.linkedin.com/in/duxan)           
###   github: https://github.com/duxan/..... 
###                                                                         
############################################################## 

# globals
source("./global.R")

# functions
source("./clean.R")
source("./predict.R")

server <- shinyServer(function(input, output, session) {
  
  predicts <- reactiveValues(first="NA", second="NA", third="NA")
  
  wordPrediction3 <- reactive({
    textInput <- cleanInput(input$text3)
    predictions <- nextWordPrediction(textInput, n=3)
    predicts$first <- predictions[1]
    predicts$second <- predictions[2]
    predicts$third <- predictions[3]
    
    return(predictions)
  })
  
  predicts.first <- reactive({
    as.character(wordPrediction3()[1])
  })
  
  predicts.second <- reactive({
    as.character(wordPrediction3()[2])
  })
  
  predicts.third <- reactive({
    as.character(wordPrediction3()[3])
  })
  
  output$predictedWord3 <- renderUI({
    div(
      if (is.na(predicts.first())) { 
        c("NA")
      } else {
        actionButton("firstWord", label = predicts$first)
      },
      if (is.na(predicts.second())) { 
        c("NA")
      } else {
        actionButton("secondWord", label = predicts$second)
      },
      if (is.na(predicts.third())) { 
        c("NA")
      } else {
        actionButton("thirdWord", label = predicts$third)
      }
    )
  })
  
  output$enteredWords3 <- renderText({ input$text3 }, quoted = FALSE)
  
  observeEvent(input$firstWord, {
    updateTextInput(session, "text3", value = paste(input$text3, predicts$first))
  })
  
  observeEvent(input$secondWord, {
    updateTextInput(session, "text3", value = paste(input$text3, predicts$second))
  })
  
  observeEvent(input$thirdWord, {
    updateTextInput(session, "text3", value = paste(input$text3, predicts$third))
  })
  
  observeEvent(input$test1.3, {
    updateTextInput(session, "text3", value = "Data Science")
  })
  
  observeEvent(input$test2.3, {
    updateTextInput(session, "text3", value = "is awesome")
  })
  
  observeEvent(input$clear3, {
    updateTextInput(session, "text3", value = "")
  })
  
  # single word prediction - Capstone App
  predict <- reactiveValues(word="NA")
  
  wordPrediction1 <- reactive({
    textInput <- cleanInput(input$text1)
    prediction <- nextWordPrediction(textInput, n=1)
    predict$word <- prediction[1]
  })
  
  output$predictedWord1 <- renderUI({
    wordPrediction1()
    return(predict$word)
  })
  
  output$enteredWords1 <- renderText({ input$text1 }, quoted = FALSE)
  
  observeEvent(input$test1.1, {
    updateTextInput(session, "text1", value = "Data Science")
  })
  
  observeEvent(input$test2.1, {
    updateTextInput(session, "text1", value = "is awesome")
  })
  
  observeEvent(input$clear1, {
    updateTextInput(session, "text1", value = "")
  })
  
  output$session_info <- renderPrint({
    capture.output(sessionInfo())
  })
  
})