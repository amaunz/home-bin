if (interactive()) {
  pkgsToLoad=c('colorout', 'setwidth', 'vimcom')
  for (pkg in pkgsToLoad) {
    if (pkg %in% rownames(utils:::installed.packages())) {
      library(pkg, character.only=T)
      pkgMsg = paste("Note: library", pkg, "loaded.")
    } else {
      pkgMsg = paste("Note: library", pkg, "is not installed.")
    }
    message(pkgMsg)
  }
}

## Don't ask me for my CRAN mirror every time
options("repos" = c(CRAN = "http://cran.rstudio.com/"))

## Create a new invisible environment for all the functions to go in so it doesn't clutter your workspace.
.env <- new.env()

## Returns a logical vector TRUE for elements of X not in Y
.env$"%nin%" <- function(x, y) !(x %in% y)

## Returns names(df) in single column, numbered matrix format.
.env$n <- function(df) matrix(names(df))

## Single character shortcuts for summary() and head().
.env$s <- base::summary
.env$h <- utils::head

## ht==headtail, i.e., show the first and last 10 items of an object
.env$ht <- function(d) rbind(head(d,10),tail(d,10))

## Show the first 5 rows and first 5 columns of a data frame or matrix
.env$hh <- function(d) if(class(d)=="matrix"|class(d)=="data.frame") d[1:5,1:5]

## Strip row names from a data frame (stolen from plyr)
.env$unrowname <- function(x) {
    rownames(x) <- NULL
    x
}

## List objects and classes (from @_inundata)
.env$lsa <- function() {
    obj_type <- function(x) { class(get(x)) }
    foo=data.frame(sapply(ls(envir=.GlobalEnv),obj_type))
    foo$object_name=rownames(foo)
    names(foo)[1]="class"
    names(foo)[2]="object"
    return(unrowname(foo))
}

## List all functions in a package (also from @_inundata)
.env$lsp <-function(package, all.names = FALSE, pattern) {
    package <- deparse(substitute(package))
    ls(
        pos = paste("package", package, sep = ":"),
        all.names = all.names,
        pattern = pattern
    )
}


## Attach all the variables above
attach(.env)

