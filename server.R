library(shiny)
data(mtcars)

# Define server logic required to perform prediction as well as updating the result display
shinyServer(
  function(input, output) {
    # Update the main panel with the values selected/inserted by the user in the sidebar panel
    output$oid_wt <- renderText({input$id_wt * 1000})
    output$oid_hp <- renderText({input$id_hp})
    output$oid_cyl <- renderText({input$id_cyl})
    output$oid_auto <- renderText({
      my_auto <- as.numeric(input$id_auto)
      if (my_auto == 0){
        'Automatic'
      }
      else{
        'Manual'
      }
    })
    
    # The main code to perform the prediction of mpg based on the car specification inserted by the user
    output$oid_mpg <- renderText({
      input$goButton
      # Prediction is performed only when the Predict button is pressed
      isolate({
        my_auto <- as.numeric(input$id_auto)
        # Grab the corresponding rows from the mtcars data frame according to the transmission type
        if (my_auto == 0){
          myData = subset(mtcars, am==0)
        }
        else{
          myData = subset(mtcars, am==1)          
        }
        # Fit a linear model using cyliner, horse power, and weight as the predictors
        fit <- lm(mpg~cyl+hp+wt, data=myData)
        # Construct a new data frame with the values from the user input
        newDF <- data.frame(wt=input$id_wt, hp=input$id_hp, cyl=as.numeric(input$id_cyl))
        # Predict the miles per galon value based on the linear model defined earlier
        pred <- predict(fit, newDF)[[1]]
        # Check if the predicted MPG is valid, and print the output accordingly
        if (pred > 0)
          pred
        else
          "Unable to predict the MPG"
      })
    })
  }
)