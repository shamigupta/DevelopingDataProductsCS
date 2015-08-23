library(shiny)

# Define UI for application that plots random distributions
shinyUI(fluidPage(
  titlePanel("IRIS Data Analysis and Prediction"),
  mainPanel(
    tags$link(rel="stylesheet", type="text/css", href="United.css"),
    tabsetPanel(
      tabPanel("Introduction",
              br(),
              br(),               
              h4(strong("The IRIS Data")),
              h5("This famous (Fisher's or Anderson's) iris data set gives the measurements in centimeters of the variables sepal length and width and petal length and width, "),
              h5("respectively, for 50 flowers from each of 3 species of iris. The species are Iris setosa, versicolor, and virginica."),
              br(),
              br(),
              h4(strong("This shiny app is to analyze features of the IRIS dataset and predict the Species")),
              h5("1. Analyse the correlation between the pairs of measurements using a scatter plot for each of the species."),
              h5("2. A model is built on this dataset using decision trees - to provide an graphical diagram of the leaves and the nodes"),
              h5("3. User interface to specify a combination of the parameter on which the model predicts the name of the Species dynamically"),
              br(),
              h5(em("Click on the tabs of the app to perform the tasks mentioned.")),
              br(),
              br(),
              h4(em(strong("Submitted by :"))),
              img(src = "Predire_Logo.jpg", height = 80, width = 120),
              span("Shami Gupta", style = "color:blue; font-weight:bold; vertical-align:bottom")
      ),
      tabPanel("Scatter Plot Analysis",
               h5("Analyze the correlation between measurements - grouped by species"),
               h5("The pairs of measurement can be selected from the the dropdown and the corresponding scatter plot is shown for analyzing "),
               selectInput(inputId = "selected_var1",
                           label = em("Choose Parameter X"),
                           choices = names(iris)[-length(names(iris))],
                           selected = names(iris)[1]),
               selectInput(inputId = "selected_var2",
                           label = em("Choose Parameter Y"),
                           choices = names(iris)[-length(names(iris))],
                           selected = names(iris)[2]),
               plotOutput("scatplot",width="90%",height="350px")
      ),
      tabPanel("Decision Tree",
               h5("A decision tree model is built using the caret's rpart package"),
               h5("The model is represented diagramatically for study based upon the IRIS dataset"),
               br(),
               radioButtons("tree_select", em("Display Tree type:"),
                            c("Rattle Plot" = "Rattle Plot",
                              "Classification Tree" = "Classification Tree"),
                            selected = "Rattle Plot", inline=TRUE),
               imageOutput("dtree")
      ),
      tabPanel("Predictions",
               fluidRow(
                 column(5,
                    h4("Select Predictor Parameters - "),
                    br(),
                    sliderInput("sl", "Sepal Length :", min = min(iris$Sepal.Length), 
                                      max = max(iris$Sepal.Length), value = mean(iris$Sepal.Length),step = 0.1),
                    sliderInput("sw", "Sepal Width :", min = min(iris$Sepal.Width), 
                                      max = max(iris$Sepal.Width), value = mean(iris$Sepal.Width),step = 0.1),
                    sliderInput("pl", "Petal Length :", min = min(iris$Petal.Length), 
                                      max = max(iris$Petal.Length), value = mean(iris$Petal.Length),step = 0.1),
                    sliderInput("pw", "Petal Width :", min = min(iris$Petal.Width), 
                                      max = max(iris$Petal.Width), value = mean(iris$Petal.Width),step = 0.1)
                 ),
                 column(6,
                    h4("Outcome - Predicted class - "),
                    br(),
                    imageOutput("preImage")
                 )
               )
      )      
    )
  )
))

