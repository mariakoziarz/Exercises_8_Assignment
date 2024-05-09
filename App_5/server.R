library(shiny)
library(ggplot2)
library(tidyr)

genes<-read.csv("TPMs_table_100genes.csv")
genes_long<-pivot_longer(data=genes,
                         cols=colnames(genes)[-1],
                         values_to = "TPMs",
                         names_to = "Sample")

shinyServer(function(input, output, session){
  
  updateSelectInput(session, "gene", choices=genes_long$GeneID)
  
  
  output$geneExpressionPlot<-renderPlot({
    
    gene_epression<-genes_long[genes_long$GeneID==input$gene, ]
    
    ggplot(gene_expression, aes(x=Sample,y=TPMs) )+
      geom_violin(color="black", aes(fill=Expression))
  })
})