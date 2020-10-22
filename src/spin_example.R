#' # This is just an R script
#' ## Rendered to a html report with knitr::spin()
#' * just by adding comments we can make a really nice output

#'
#' > And the code runs just like normal, eg. via `Rscript` after all,
#' __comments__ are just *comments*.
#'
#' ## The report begins here
#+
head(mtcars)

#' ## A chart
#+ fig.width=8, fig.height=8
heatmap(cor(mtcars))

#' ## Some tips
#'
#' 1. Optional chunk options are written using `#+`
#' 1. You can write comments between `/*` and `*/` like C comments
#' (the preceding # is optional)

