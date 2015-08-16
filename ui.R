library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Miles per galon predictor using linear model from mtcars data"),
  sidebarPanel(
    numericInput('id_wt', 'Car weight (in lb/1000):', 1.6, min = 1, max = 6, step = 0.1),
    numericInput('id_hp', 'Horse Power:', 110, min=50, max=600, step=1),
    radioButtons('id_cyl', 'Cylinders:',
                 c('4'=4,
                   '6'=6,
                   '8'=8),
                 4),
    radioButtons('id_auto', 'Transmission type:',
                 c('Automatic'=0,
                   'Manual'=1),
                 0),
    actionButton("goButton", "Predict!")
  ),
  mainPanel(
    h3('Car specification entered:'),
    h4('Weight (lbs)'),
    verbatimTextOutput("oid_wt"),
    h4('Horse Power'),
    verbatimTextOutput("oid_hp"),
    h4('Number of cylinders'),
    verbatimTextOutput("oid_cyl"),
    h4('Transmission'),
    verbatimTextOutput("oid_auto"),
    h3('Estimated miles per galon:'),
    h4('Mpg predicted'),
    verbatimTextOutput("oid_mpg")
  )
))