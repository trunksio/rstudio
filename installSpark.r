
check_install <- function(p) {
  if (!(p %in% rownames(installed.packages()))) {
    install.packages(p, dependencies=TRUE, repo='https://cran.ma.imperial.ac.uk/')
  }
}

check_install("sparklyr")
check_install("odbc")
library(sparklyr)
spark_install(version = "2.1.1", hadoop_version = "2.7")
