# Collect arguments for exported functions only
pkg <- "cvdprevent"
exports <- getNamespaceExports(pkg) # exported objects only

test <-
  tibble::tibble(
    function_name = exports,
    args = purrr::map(
      exports,
      ~ {
        obj <- get(.x, envir = asNamespace(pkg))
        if (is.function(obj)) names(formals(obj)) else character(0)
      }
    )
  ) |>
  dplyr::filter(lengths(args) > 0)


obj <- get("cvd_clear_cache", envir = asNamespace(pkg))
if (is.function(obj)) {
  names(formals(obj))
} else {
  character(0)
}
