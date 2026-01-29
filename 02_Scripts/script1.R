x<-rnorm(1000)
hist(x)
pdf("03_Results/mi_histograma_feo.pdf")
hist(x,color="yellow4")
boxplot(x)
dev.off()


usethis::use_git()
