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

#define function to select data and prepare a plot
function(input, output, session){
  
  #update gene selection choices with default option "--gene--"
  updateSelectInput(session, "gene", choices=c("--gene--", unique(genes_long$GeneID)), selected = "--gene--")
  
  #create a plot based on the selected gene
  output$geneExpressionPlot<-renderPlot({
    
    #if the gene not selected do not show a plot
    if (input$gene == "--gene--") {
      return(NULL)
    }
    #get the data for selected gene
    gene_expression<-genes_long[genes_long$GeneID==input$gene, ]
   
    #create scatter plot
    ggplot(gene_expression, aes(x=Sample,y=Expression, fill=Sample) )+
      geom_point(aes(color=Sample))+
      ylim(0,max(genes_long$Expression))
  })
}