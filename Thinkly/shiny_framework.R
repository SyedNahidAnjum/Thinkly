library(shiny)
library(dplyr)
library(shinythemes)
# Define the user interface (UI)
ui<-shinyUI(
  navbarPage(
    title = div(
      style = "color: white; font-weight: bold; font-size: 24px;",
      "Thinkly: Predicts Your Next Word Thought"
    ),
    
    theme = shinythemes::shinytheme("flatly"),  # Using a clean theme from the shinythemes package
    
    # Custom CSS for input box and navigation bar
    tags$style(HTML("
      .navbar {
        background-color: #2C3E50; /* Dark navigation bar */
      }
      .navbar-default .navbar-nav > li > a {
        color: white; /* White text in nav bar */
      }
      .navbar-default .navbar-nav > .active > a {
        background-color: #18BC9C; /* Highlight active tab */
      }
      .form-control {
        background-color: #F3F3F3; /* Light grey background for input box */
        border-color: #18BC9C;     /* Green border for input box */
        color: #2C3E50;           /* Dark text */
      }
      body {
        background-color: #ECF0F1; /* Light background for the app */
      }
    ")),
    
    tabPanel("Next Word Prediction",
             HTML("<strong>Author: Syed Nahid</strong>"),
             br(),
             
             sidebarLayout(
               sidebarPanel(
                 helpText("This is a demonstration of NLP model for predicting the next word."),
                 hr(),
                 textInput("inputText", "Enter a word below:", value = ""),
                 hr()
               ),
               
               mainPanel(
                 h2("The Next word is"),
                 h5("The next word is guessed using some cool NLP magic on the learning from Coursera’s Data Science Capstone Project from Johns Hopkins University !."),

                 strong("Your Input:"),
                 verbatimTextOutput("inputWords"),
                 hr(),
                 strong("Predicted Next Word:"),
                 strong(code(textOutput("NextWord"))),
                 hr()
               )
             )
    )
  )
)



# Define server logic for the prediction model
suppressPackageStartupMessages(c(
  library(shiny),
  library(tm),
  library(stringr)))


source("PredictWordAlgo.R")




server<-shinyServer(function(input, output) {
  output$NextWord <- renderPrint({
    result <- predictWord(input$inputText)
    result
  });
  output$inputWords <- renderText({
    input$inputText});
}
)


# Run the application
shinyApp(ui = ui, server = server)
