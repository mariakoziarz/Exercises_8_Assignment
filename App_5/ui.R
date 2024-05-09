library(shiny)
library(ggplot2)
library(tidyr)

#load the data
genes<-read.csv("TPMs_table_100genes.csv")

#make it long
genes_long<-pivot_longer(data=genes,
                         cols=colnames(genes)[-1],
                         values_to = "Expression",
                         names_to = "Sample")

#define ui for the aplication
shinyUI(fluidPage(
  
  #add the title
  titlePanel("Gene Expression Viewer"),
  
  #create side bar for input gene selection
  sidebarLayout(
    sidebarPanel(
      selectInput("gene", "Select Gene:", choices = genes_long$GeneID)
    ),
    
    #display the plot
    mainPanel(plotOutput("geneExpressionPlot")    )
    
  )
))