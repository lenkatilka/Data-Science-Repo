library(shiny)
library(googleVis)
library(ggplot2)

Cities<-read.csv("cities.csv",sep=",")
correctState<-rep(1,each=nrow(Cities))
Cities<-data.frame(Cities,correctState)
answer<-"Spain"

#======================================================
questionOptions<-function(multiply){
### set a random seed; this random seed generator does not reproduce the same numbers
set.seed( as.integer((as.double(Sys.time())*1000*multiply+Sys.getpid()) %% 2^31) )

randomCityIndex<-round(runif(1,min=1,max=nrow(Cities))) # choose a random country
randomCity<-as.character(Cities$City[randomCityIndex])

q<-c(as.character(Cities$State[randomCityIndex]),as.integer(randomCityIndex))

### make a random permuation of the indices 1 through 3, no repetition
indices<-(1:3)
inidces<-sample(indices,replace=FALSE)
### random choice of countries as options
randOption<-sample(c(1:nrow(Cities)),replace=FALSE)
randOptionText<-c(" "," "," ")
for(k in 1:3){
  #      round(runif(1,min=1,max=nrow(Exports)))
  randOptionText[k]<-paste(k,'.',as.character(Cities$State[randOption[k]]))
}
### set some of the options to be a correct choice
randOption<-round(runif(1,min=1,max=3))
randOptionText[randOption]<-paste(randOption,'.',q[1])

randomCity<-paste("Where is ",randomCity, "?")
return(list(randOptionText=randOptionText,randomCity=randomCity, q=q))
}
#======================================================
  
shinyServer( function(input,output) {


  questions<-{}
  q<-{}
  for(i in 1:10){
    
    dummy<-questionOptions(10*i)
    randomCity<-dummy$randomCity
    randOptionText<-dummy$randOptionText
    questions<-rbind(questions,c(randomCity,randOptionText))
    q<-rbind(q,dummy$q)    
  }

  answer <- eventReactive(input$button,{

    correct<-rep(0,each=10)
    correctState<-rep(0,each=100)
    if(q[1,1] == input$inputGuess1){
      correct[1]<-1
      ind<-as.numeric(q[1,2])
      correctState[ind]<-1
      }
    if(q[2,1] == input$inputGuess2){
      correct[2]<-1
      ind<-as.numeric(q[2,2])
      correctState[ind]<-1
    }
    if(q[3,1] == input$inputGuess3){
      correct[3]<-1
      ind<-as.numeric(q[3,2])
      correctState[ind]<-1
    }
    if(q[4,1] == input$inputGuess4){
      correct[4]<-1
      ind<-as.numeric(q[4,2])
      correctState[ind]<-1
    }
    if(q[5,1] == input$inputGuess5){
      correct[5]<-1
      ind<-as.numeric(q[5,2])
      correctState[ind]<-1
    }
    if(q[6,1] == input$inputGuess6){
      correct[6]<-1
      ind<-as.numeric(q[6,2])
      correctState[ind]<-1
    }
    if(q[7,1] == input$inputGuess7){
      correct[7]<-1
      ind<-as.numeric(q[7,2])
      correctState[ind]<-1
    }
    if(q[8,1] == input$inputGuess8){
      correct[8]<-1
      ind<-as.numeric(q[8,2])
      correctState[ind]<-1
    }
    if(q[9,1] == input$inputGuess9){
      correct[9]<-1
      ind<-as.numeric(q[9,2])
      correctState[ind]<-1
    }
    if(q[10,1] == input$inputGuess10){
      correct[10]<-1
      ind<-as.numeric(q[10,2])
      correctState[ind]<-1
    }
    answer<-list(correct=correct, correctState=correctState, q=q)

  })
  CitiesModified<-reactive({
    
    #correctState<-rep(0,each=nrow(Cities))
    correct<-answer()$correctState
    
    CitiesDummy<-cbind(Cities,correct)
    CitiesDummy$correct<-as.numeric(CitiesDummy$correct)
    for (i in 1:10){
      ind<-as.numeric(q[i,2])
      if(correct[ind]==1){
        indices<-c(CitiesDummy$State==CitiesDummy$State[ind])
        CitiesDummy$correct[indices]<-1
      }
    }
    
    CitiesModified<-CitiesDummy
    
  }
)
  
#### Google Map of US
  output$GoogleMapChart<-renderGvis({
    if(input$button==0){
      GMC<-gvisGeoChart(Cities, locationvar = "State",hovervar = "City",sizevar = "Population",
                        options=list(region="US",displayMode="markers",resolution="provinces", legend='none'))}
    else{
        GMC<-gvisGeoChart(CitiesModified(),locationvar="State", colorvar = "correct",
                      options=list(region="US",displayMode="regions",resolution="provinces", legend='none'))
    }
    return(GMC)
  })
  
#### Text Outputs
  output$q1<-renderUI(HTML(paste(questions[1,1],"Hint: ", questions[1,2], questions[1,3], questions[1,4], sep='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;')))
  output$q2<-renderUI(HTML(paste(questions[2,1],"Hint: ", questions[2,2], questions[2,3], questions[2,4], sep='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;')))
  output$q3<-renderUI(HTML(paste(questions[3,1],"Hint: ", questions[3,2], questions[3,3], questions[3,4], sep='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;')))
  output$q4<-renderUI(HTML(paste(questions[4,1], "Hint: ", questions[4,2], questions[4,3], questions[4,4], sep='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;')))
  output$q5<-renderUI(HTML(paste(questions[5,1], "Hint: ", questions[5,2], questions[5,3], questions[5,4], sep='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;')))
  output$q6<-renderUI(HTML(paste(questions[6,1], "Hint: ", questions[6,2], questions[6,3], questions[6,4], sep='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;')))
  output$q7<-renderUI(HTML(paste(questions[7,1], "Hint: ", questions[7,2], questions[7,3], questions[7,4], sep='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;')))
  output$q8<-renderUI(HTML(paste(questions[8,1], "Hint: ", questions[8,2], questions[8,3], questions[8,4], sep='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;')))
  output$q9<-renderUI(HTML(paste(questions[9,1], "Hint: ", questions[9,2], questions[9,3], questions[9,4], sep='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;')))
  output$q10<-renderUI(HTML(paste(questions[10,1], "Hint: ", questions[10,2], questions[10,3], questions[10,4], sep='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;')))

#### Pie Output
  output$GooglePie<-renderGvis({
    correct<-answer()$correct
    CitiesCorrect<-data.frame(correct=c("correct","incorrect"),freq=c(sum(correct),length(correct)-sum(correct)))
    GP<-gvisPieChart(CitiesCorrect)
    return(GP)
  })
#### Histogram Output
  output$htmlpic<-renderPlot({
    correct<-answer()$correct
    dat<-data.frame(x=correct,correct=correct>0.5)
    n1<-qplot(correct,data=dat, geom="histogram",fill=correct)
    return(n1)
  })
  
  output$ans<-renderPrint({
    if(input$buttonCorrectAnswers>0){
      return(q[,1])
    }
    else{return("")}
  })
})