x<-rnorm(1000)
hist(x)
pdf("03_Results/mi_histograma_feo.pdf")
hist(x,color="pink3")
boxplot(x)
dev.off()

