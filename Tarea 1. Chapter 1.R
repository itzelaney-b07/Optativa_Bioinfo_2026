library()
library(gplots)  
search()
ls(2)
demo(graphics)
#Ejercicio 1: Descargar markdown y ggplot2 
#Las descargué directo en R
library(gplots)
library(markdown)
#####
help(solve)
help.search("clustering")
example("hclust")
#Ejercicio 2:
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.22")

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ggtreeExtra")
BiocManager::install("ggtree")
#| eval: false

