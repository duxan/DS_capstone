suppressPackageStartupMessages(c(
  library(shinydashboard),
  library(shiny),
  library(shinyjs),
  library(tm),
  library(stringr),
  library(markdown),
  library(stylo)))

# read model
final4Data <- as.data.frame(readRDS(file="./4gram.RData"))
final3Data <- as.data.frame(readRDS(file="./3gram.RData"))
final2Data <- as.data.frame(readRDS(file="./2gram.RData"))

