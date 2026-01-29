x<-rnorm(1000)
hist(x)
pdf("03_Results/mi_histograma_feo.pdf")
hist(x,color="green2")
boxplot(x)
dev.off()

usethis::use_git()

0#| eval: false
usethis::create_github_token()
#| eval: false
gitcreds::gitcreds_set()

usethis::use_git_config(
  user.name = "itzelaney-b07",
  user.email = "inovella07@alumnos.uaq.mx"
)
usethis::use_github()
