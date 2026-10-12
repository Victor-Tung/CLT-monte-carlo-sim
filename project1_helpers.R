# Shared helper functions for CLT Project 1

skewness_manual <- function(x) {
  x <- x[is.finite(x)]
  m <- mean(x)
  s <- sd(x)
  if (length(x) < 3 || s == 0) return(NA_real_)
  mean((x - m)^3) / s^3
}

kurtosis_excess_manual <- function(x) {
  x <- x[is.finite(x)]
  m <- mean(x)
  s <- sd(x)
  if (length(x) < 4 || s == 0) return(NA_real_)
  mean((x - m)^4) / s^4 - 3
}

simulate_sample_means <- function(generator, n, B = 10000, seed = 1828) {
  set.seed(seed)
  replicate(B, mean(generator(n)))
}

summarize_means <- function(means, theoretical_mean, theoretical_se) {
  data.frame(
    simulated_mean = mean(means),
    theoretical_mean = theoretical_mean,
    mean_error = mean(means) - theoretical_mean,
    simulated_se = sd(means),
    theoretical_se = theoretical_se,
    se_ratio = sd(means) / theoretical_se,
    skewness = skewness_manual(means),
    excess_kurtosis = kurtosis_excess_manual(means),
    q025 = unname(quantile(means, 0.025)),
    q975 = unname(quantile(means, 0.975))
  )
}

run_experiment <- function(name, generator, theoretical_mean, theoretical_se_fun,
                           sample_sizes = c(1, 5, 10, 30, 50, 100),
                           B = 10000, seed = 1234) {
  results <- lapply(sample_sizes, function(n) {
    means <- simulate_sample_means(generator, n, B, seed + n)
    out <- summarize_means(means, theoretical_mean, theoretical_se_fun(n))
    out$population <- name
    out$n <- n
    out$simulations <- B
    out$means <- list(means)
    out
  })
  do.call(rbind, results)
}

plot_sampling_distribution <- function(results, n_value) {
  row <- results[results$n == n_value, , drop = FALSE]
  if (nrow(row) != 1) stop("Requested n is not in the experiment results.")
  means <- row$means[[1]]
  hist(means, breaks = 40, probability = TRUE,
       main = paste(results$population[1], "sampling distribution, n =", n_value),
       xlab = "Sample mean", col = "skyblue", border = "white")
  curve(dnorm(x, mean(means), sd(means)), add = TRUE, col = "red", lwd = 2)
}

qq_sampling_distribution <- function(results, n_value) {
  row <- results[results$n == n_value, , drop = FALSE]
  if (nrow(row) != 1) stop("Requested n is not in the experiment results.")
  qqnorm(row$means[[1]], main = paste("Q-Q plot:", results$population[1], "n =", n_value))
  qqline(row$means[[1]], col = "red", lwd = 2)
}

results_table <- function(results) {
  results[, c("population", "n", "simulations", "simulated_mean",
              "theoretical_mean", "mean_error", "simulated_se",
              "theoretical_se", "se_ratio", "skewness",
              "excess_kurtosis", "q025", "q975")]
}
