library(shiny)
library(shinydashboard)
library(maps)
library(dplyr)
library(leaflet)
library(shinycssloaders)
library(shinythemes)
library(rio)
library(DT)
library(stargazer)


dashboardPage(
  dashboardHeader(title = "Regression analysis", dropdownMenuOutput("msgOutput")),
  dashboardSidebar(
    sliderInput(
      "Slider",
      label = h3("Train/Test Split %"),
      min = 0,
      max = 100,
      value = 75
    ),
    textOutput("cntTrain"),
    textOutput("cntTest"),
    br()
  ),
  dashboardBody(
    fluidPage(
      box(
        selectInput(
          "SelectX",
          label = "Select variables:",
          choices = names(longley),
          multiple = TRUE,
          selected = names(longley)
        ),
        solidHeader = TRUE,
        width = "3",
        status = "primary",
        title = "X variables"
      ),
      box(
        selectInput("SelectY", label = "Select variable to predict:", choices = names(longley)),
        solidHeader = TRUE,
        width = "3",
        status = "primary",
        title = "Y variable"
      )
    ),
    
    fluidPage(  
      
      tabBox(
        id = "tabset",
        height = "1000px",
        width = 12,
        
        tabPanel("Data",
                 box(withSpinner(DTOutput(
                   "Data"
                 )), width = 12)),
        tabPanel(
          "Data Summary",
          box(withSpinner(verbatimTextOutput("Summ")), width = 6),
          box(withSpinner(verbatimTextOutput("Summ_old")), width = 6)
        ),
        tabPanel(
          "Model",
          box(
            withSpinner(verbatimTextOutput("Model")),
            width = 6,
            title = "Model Summary"
          ),
          box(
            withSpinner(verbatimTextOutput("ImpVar")),
            width = 5,
            title = "Variable Importance"
          )
        ),
        tabPanel(
          "Prediction",
          box(withSpinner(plotOutput("Prediction")), width = 6, title = "Best Fit Line"),
          box(withSpinner(plotOutput("residualPlots")), width = 6, title = "Diagnostic Plots")
        )
      )
    )
  )
)