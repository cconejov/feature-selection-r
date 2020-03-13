#
# Tests for forward_selection()
#

#' Sample custom scorer that fits a model and returns
#' an appropriate score for the feature selection problem.
#'
#' @param data A data.frame with features and response columns.
#'
#' @return The mean squared error (MSE) of the model
scorer <- function(data) {
   model <- lm(Y ~ ., data)
   return(mean(model$residuals^2))
}

# This test creates a dataset that has 5 features that are are used to compute `Y`.
# The remaining features are independent of `Y`.
# This test should select the 5 feature columns used to compute `Y`.
testthat::test_that("relevant features remain", {
  # Create dataframe and remove Y true column; keep Y.
  set.seed(0)
  data <- dplyr::select(tgp::friedman.1.data(), -Ytrue)
  X <- data[1:(length(data)-1)]
  y <- data[length(data)]

  # Run Test compare scores with expected ones
  set.seed(1230)
  results <- forward_select(scorer, X, y, 4, 4)
  testthat::expect_setequal(results, c(1, 2, 4, 5))
})

testthat::test_that("X and y tests", {
  set.seed(0)
  data <- dplyr::select(tgp::friedman.1.data(), -Ytrue)
  X <- data[1:(length(data)-1)]
  y <- data[length(data)]

  # X and y are Dataframes
  testthat::test_that("X param is a data.frame (or tibble)", {
    testthat::expect_error(forward_select(scorer, 0, y), "data.frame")
    testthat::expect_error(forward_select(scorer, "nonsense", y), "data.frame")
    testthat::expect_error(forward_select(scorer, c(), y), "data.frame")
    testthat::expect_error(forward_select(scorer, list(), y), "data.frame")
  })
  testthat::test_that("y param is a data.frame (or tibble)", {
    testthat::expect_error(forward_select(scorer, X, 0), "data.frame")
    testthat::expect_error(forward_select(scorer, X, "nonsense"), "data.frame")
    testthat::expect_error(forward_select(scorer, X, c()), "data.frame")
    testthat::expect_error(forward_select(scorer, X, list()), "data.frame")
  })

  # check that min number of features is greater or equal to one
  testthat::expect_error(forward_select(scorer, X, y, 0, 6))
})

# check that the number of features are between min and max number of features
testthat::test_that("min_features and max_features works properly", {
  data <- dplyr::select(tgp::friedman.1.data(), -Ytrue)
  X <- data[1:(length(data)-1)]
  y <- data[length(data)]
  testthat::expect_gte(length(forward_select(scorer, X, y, 5, 6)), 4)
  testthat::expect_lte(length(forward_select(scorer, X, y, 5, 6)), 6)
  testthat::expect_error(forward_select(scorer, X, y, 6, 5))
})

# 'scorer' is a function
testthat::test_that("`scorer param is a function", {
  testthat::expect_error(forward_select(0, X, y, 4, 4), "scorer")
})

# Test output arrays are not empty
testthat::test_that("features returned is not empty", {
  # Create dataframe and remove Ytrue column; keep Y.
  data <- dplyr::select(tgp::friedman.1.data(), -Ytrue)
  X <- data[1:(length(data)-1)]
  y <- data[length(data)]

  # Run Test
  testthat::expect_gt(length(simulated_annealing(scorer, X, y)), 0)
  testthat::expect_gt(sum(simulated_annealing(scorer, X, y, bools = TRUE)), 0)
})
