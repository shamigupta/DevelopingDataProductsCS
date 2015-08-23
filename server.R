library(shiny)
library(caret)
#library(rattle)
library(ggplot2)
library(rpart.plot)
library(e1071)

data(iris)
modFit= train(Species~., method="rpart", data=iris)

shinyServer(function(input, output) {

  output$scatplot <- renderPlot({
    xvar= input$selected_var1
    yvar= input$selected_var2
    ggplot(iris,aes_string(x=xvar,y=yvar, colour="Species")) + geom_point(size=2.5) +
      xlab(input$selected_var1) +  ylab(input$selected_var2) + 
      ggtitle(paste("Iris - ",input$selected_var1, " vs ", input$selected_var2)) +
      geom_smooth(method="lm") +
      facet_grid(. ~ Species)
  })

  output$dtree <- renderImage({
    outfile <- tempfile(fileext='.png')
    if (input$tree_select == "Classification Tree") {
      png(outfile)
      plot(modFit$finalModel, uniform=TRUE, main="")
      text(modFit$finalModel, use.n=TRUE, all=TRUE, cex=.8)
      dev.off()
      list(src = outfile, contentType = 'image/png', width = 600, height = 450, alt = "Classification Tree")
    } else {
      filename <- normalizePath(file.path('fancyRpartPlot.JPG'))
      list(src = filename, alt = paste("Rattle Plot"))
    }
  }, deleteFile = FALSE)

  output$preImage <- renderImage({
    testdata= iris[0,]
    testdata= subset(testdata, select=-Species)
    testdata[1,"Sepal.Length"]= input$sl
    testdata[1,"Sepal.Width"]= input$sw
    testdata[1,"Petal.Length"]= input$pl
    testdata[1,"Petal.Width"]= input$pw
    op=predict(modFit,newdata=testdata)
    filename <- normalizePath(file.path(paste(as.character(op),'.jpg', sep='')))
    list(src = filename, alt = paste("Iris type ", paste(as.character(op))))
  }, deleteFile = FALSE)

})
