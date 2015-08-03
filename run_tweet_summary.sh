#!/usr/bin/env r

library(rmarkdown)
rmarkdown::render(input = "index.Rmd", output_file = "index.html")
