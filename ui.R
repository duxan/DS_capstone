dashboardPage(
  dashboardHeader(title = "Coursera Data Science Capstone"),
  dashboardSidebar(sidebarMenu(
    menuItem("About", tabName = "about", icon = icon("info-circle")),
    menuItem("Capstone App", tabName = "app1", icon = icon("cube")),
    menuItem("3-choice App", tabName = "app3", icon = icon("cubes")),
    menuItem("sessionInfo", tabName = "session", icon = icon("gears"))
  )
  #footer
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "app1",
        fluidRow(
          box(
            div(
              textInput("text1", h3("Start your sentence:"), ""),
              span(style="color:grey",("Only English words are supported")),
              div(style="color:grey",
                span("For example start with "),
                actionLink("test1.1", "Data Science"),
                span(" or "),
                actionLink("test2.1", "is awesome"),
                span(" | "),
                actionLink("clear1", "CLEAR")
              ),
              br(), hr(),
              h4("Your predicted word:"),
              span(style="color:darkred", strong(h3(uiOutput("predictedWord1")))),
              br(),hr(),
              h4("Full sentence:"),
              em(h4(textOutput("enteredWords1"))), align="center")))),
      tabItem(tabName = "app3",
              fluidRow(
                box(
                  div(
                    textInput("text3", h3("Start your sentence:"), ""),
                    span(style="color:grey",("Only English words are supported")),
                    div(style="color:grey",
                        span("For example start with "),
                        actionLink("test1.3", "Data Science"),
                        span(" or "),
                        actionLink("test2.3", "is awesome"),
                        span(" | "),
                        actionLink("clear3", "CLEAR")
                    ),
                    br(), hr(),
                    h4("Select one predicted word:"),
                    span(style="color:darkred", strong(h3(uiOutput("predictedWord3")))),
                    br(),hr(),
                    h4("Full sentence:"),
                    em(h4(textOutput("enteredWords3"))), align="center")))),
      tabItem(tabName = "about",
        fluidRow(
          box(
            includeMarkdown("./about.md")
          )
        )
      ),
      tabItem(tabName = "session",
              fluidRow(
                box(
                  htmlOutput("session_info")
                )
              )
      )
)))