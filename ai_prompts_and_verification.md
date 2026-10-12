# AI Prompt Record — CLT Project 1

This file records the main AI prompts and follow-up questions used while developing and checking the Central Limit Theorem Monte Carlo investigation.

## 1. Understanding the assignment

**Prompt:**

> What are the distributions that I need to look into for this experiment, and based on this document what are the deliverables requested for the end product?

**Purpose:**

To identify the five required distributions, the three extra-credit distributions, and the required analysis components.

**Resulting decision:**

The five required distributions were Standard Normal, Six-Sided Die, Exponential, Small Binomial, and Cauchy. The three extra-credit distributions were Dependent Machine Failure, Non-identical Bernoulli, and the Life/Death Population.

## 2. Organizing the project

**Prompt:**

> How do I hook up RStudio to GitHub, and is there a standard practice in organizing these files that I should follow?

**Purpose:**

To organize the project as a reproducible RStudio and GitHub repository.

**Resulting decision:**

The project was organized with separate Quarto files for the distributions, a shared `project1_helpers.R` file, a final summary document, and a separate prompt record.

## 3. Creating the base experiments

**Prompt:**

> For all eight distributions, help me create the base experimentation files needed to analyze and explore the distributions. Before giving me each file, provide a description of each distribution.

**Purpose:**

To create editable Quarto starting files containing simulations, sample means, numerical summaries, histograms, and Q-Q plots.

**Resulting decision:**

Each distribution received its own `.qmd` file. A shared helper file was used for reusable simulation and summary functions.

## 4. Choosing sample sizes

**Prompt:**

> What experimental values should I test for n in each distribution, and which parameters should remain fixed?

**Purpose:**

To distinguish the sample size (n) from the number of repeated simulations and establish a consistent experiment.

**Resulting decision:**

The main sample sizes were selected as:

```r
c(1, 5, 10, 20, 30, 50, 100, 200)
```

The distribution parameters, simulation count, and random seed were kept fixed while (n) changed.

## 5. Defining approximate normality

**Prompt:**

> What are good measurements for a distribution becoming approximately normal?

**Purpose:**

To establish evidence-based criteria instead of relying only on visual inspection.

**Measurements used:**

- Histogram shape and symmetry
- Normal Q-Q plot
- Skewness
- Excess kurtosis
- Simulated mean versus theoretical mean
- Simulated standard error versus theoretical standard error
- Possible influence of outliers

**Operational guideline:**

A sampling distribution was considered approximately normal when several forms of evidence agreed. Suggested numerical guidelines were absolute skewness near or below 0.20, absolute excess kurtosis near or below 0.50, and a simulated-to-theoretical SE ratio reasonably close to 1.

These are project criteria rather than universal mathematical cutoffs. The final conclusion must explain the evidence and limitations.

## 6. Understanding the project goal

**Prompt:**

> For every distribution, is the main goal to find a value of n where all of these factors meet so we can argue that it is approximately normal?

**Resulting decision:**

The goal is to identify the smallest defensible sample size for each distribution separately. The project is not looking for one sample size that makes every population normal.

## 7. Handling the Cauchy distribution

**Prompt:**

> Is the Cauchy distribution expected to never be close to normal?

**Resulting decision:**

The Cauchy distribution is expected not to follow ordinary CLT behavior because its theoretical mean and variance do not exist. Its sample means remain Cauchy-distributed rather than becoming normally distributed as (n) increases.

## 8. Fixing the `match.names()` error

**Prompt:**

> Fix the `match.names()` error caused by code that combines results with `do.call(rbind, ...)` while storing `means = list(means)`.

**Problem identified:**

The original code tried to combine ordinary numerical summary columns and a list-column containing the full vector of simulated means in the same row-binding operation.

**Correction made:**

The simulated means were stored separately:

```r
result_means <- vector("list", length(sample_sizes))
```

The numerical results data frame was built first, and the list-column was added afterward:

```r
results$means <- result_means
```

This structure was applied to the extra-credit files to avoid the `match.names()` error.

## 9. Correcting the extra-credit files

**Prompt:**

> Modify the original extra-credit files while preserving their overall structure. Use `source("../project1_helpers.R")`, remove the fragile row-binding pattern, use the specified distributions and parameters, include the required numerical summaries and plots, and keep the interpretation sections concise.

**Corrections made:**

- File 06 uses the dependent machine-failure process with `baseline_rate = 1`, `beta = 1.25`, and `reference_time = 1`.
- File 07 uses probabilities decreasing from 0.90 to 0.50 and the adjusted theoretical SE.
- File 08 uses the supplied discrete age-at-death population from ages 0 through 100.
- All three files use sample sizes from 5 through 200.

## Verification and corrections

The files were checked by rendering them with Quarto. Rendering exposed errors involving the original results-table construction, including the `match.names()` error. The affected code was rewritten to separate the numerical summaries from the stored simulation vectors.

Before submission, each file should be rendered again from the project root, checked visually, and committed to GitHub with the resulting source files and final summary.
