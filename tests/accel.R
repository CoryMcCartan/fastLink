# Test performance and EM acceleration ---------------

data(samplematch)

# dfA = dplyr::slice_sample(dfA, n=2e3, replace=TRUE)
# dfB = dplyr::slice_sample(dfB, n=1e3, replace=TRUE)

run_match = function(...) {
    options(...)
    invisible(fastLink(
        dfA = dfA, dfB = dfB,
        varnames = c("firstname", "middlename", "lastname", "housenum", "streetname", "city", "birthyear"),
        stringdist.match = c("firstname", "middlename", "lastname", "streetname", "city"),
        partial.match = c("firstname", "lastname", "streetname"),
        n.cores = 1L
    ))
}


res = bench::mark(
    run_match(FL_gc=FALSE),
    run_match(FL_gc=TRUE),
    min_iterations = 10,
    check = FALSE,
    memory = FALSE
)

times = lapply(res$time, as.numeric)
t.test(times[[1]], times[[2]])
