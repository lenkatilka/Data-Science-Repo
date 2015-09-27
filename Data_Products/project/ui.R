library(shiny)
library(googleVis)

shinyUI(
  pageWithSidebar(
    headerPanel("Guess the State Game"),
    sidebarPanel(
      h1("Your Map"),
      htmlOutput("GoogleMapChart"),
      h2("Statistics of Your Game"),
      p("(Statistics is to appear after you submit your answers.)"),
      htmlOutput("GooglePie"),
      plotOutput("htmlpic")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Game",

                 h1("Let's play a game! Can you guess the state?"),
                 p(""),
                 htmlOutput('q1'),
                 textInput("inputGuess1", "Input your guess"),
                 htmlOutput('q2'),
                 textInput("inputGuess2", "Input your guess"),
                 htmlOutput('q3'),
                 textInput("inputGuess3", "Input your guess"),
                 htmlOutput('q4'),
                 textInput("inputGuess4", "Input your guess"),
                 htmlOutput('q5'),
                 textInput("inputGuess5", "Input your guess"),
                 htmlOutput('q6'),
                 textInput("inputGuess6", "Input your guess"),
                 htmlOutput('q7'),
                 textInput("inputGuess7", "Input your guess"),
                 htmlOutput('q8'),
                 textInput("inputGuess8", "Input your guess"),
                 htmlOutput('q9'),
                 textInput("inputGuess9", "Input your guess"),
                 htmlOutput('q10'),
                 textInput("inputGuess10", "Input your guess"),
                 actionButton('button',"Submit your answers!"),
                 actionButton('buttonCorrectAnswers',"Show me correct answers!"),
                 verbatimTextOutput('ans')
        ),
                 
        tabPanel("Instructions (Documentation)",
                 h1("Instructions"),
                 h4("This is a geographical game. I pulled out for you the 100 largest cities (by means of population)
                    in the United States. Your quest is to guess in which state is the city located. To help you out,
                    I prepared three different options (one of them is correct). Moreover, you can look at the map 
                    on the side bar and see the city and its population. This way, you can indetify the state on the map
                    and this will help you to guess in which state is the city located."),
                h4("Once you type down your guesses in the text boxes, push the Submit button to submit your answers. 
                   You will see a very simple statistics of your game - a pie chart and a histogram. Also, the states that
                   were guessed correctly will be highlighted on the map."),
                h4("You can see the correct answers if you choose to. But I hope you will make your guesses first, otherwise
                   its not fun!"),
                h4("I hope you will enjoy this game and learn something new about the largest cities in United States!")
        )
      )
    )
  )
)