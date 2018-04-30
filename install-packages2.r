check_install <- function(p) {
  if (!(p %in% rownames(installed.packages()))) {
    install.packages(p, dependencies=TRUE, repo='https://cran.ma.imperial.ac.uk/')
  }
}

install.packages("udunits2",configure.args='--with-udunits2-include=/usr/include/udunits2',repo='https://cran.ma.imperial.ac.uk/')
check_install('ggraph')
