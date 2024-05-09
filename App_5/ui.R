library(shiny)


shinyUI(fluidPage(
  
 
  titlePanel("Gene Expression Viewer"),
  
  
  sidebarLayout(
    sidebarPanel(
      selectInput("gene", "Select Gene:", choices = NULL)
    ),
    
    fluidRow(
      column(width=8,
        plotOutput("geneExpressonPlot")
      )
    )
    
  )
))
