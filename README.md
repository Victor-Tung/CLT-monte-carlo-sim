# CLT-monte-carlo-sim
R-based Monte Carlo study of how fast sampling distributions approach normality across distributions, sample sizes, and dependence. The analyses compare symmetric, discrete, skewed, heavy-tailed, dependent, non-identically distributed, and irregular populations. Each analysis generates numerical summaries and visual diagnostics for evaluating how closely the sampling distribution resembles a normal distribution.

## Repository Contents

### Core analyses

- `01_standard_normal.qmd` - Normal population baseline.
- `02_six_sided_die.qmd` - Discrete uniform population from 1 through 6.
- `03_exponential.qmd` - Right-skewed Exponential population with rate 1.
- `04_binomial_small.qmd` - Discrete Binomial(5, 0.10) population.
- `05_cauchy.qmd` - Heavy-tailed Cauchy population without a finite ordinary mean or variance.

### Additional analyses

- `extra_credit/06_dependent_machine_failure.qmd` - Sequential failure-time process with dependence between observations.
- `extra_credit/07_non_identical_bernoulli.qmd` - Independent Bernoulli observations with changing success probabilities.
- `extra_credit/08_life_death_population.qmd` - Custom discrete age-at-death population from ages 0 through 100.

### Shared and summary files

- `project1_helpers.R` — Shared simulation, summary, skewness, kurtosis, histogram, and Q-Q plot functions.
- `final_summary.qmd` — Cross-analysis comparison and overall findings.
- `ai_prompts.md` — Record of AI-assisted development and validation.
- `README.md` — Repository documentation and usage instructions.

## Analysis Workflow

Each analysis follows the same general workflow:

1. Define a population generator.
2. Select several sample sizes.
3. Simulate many sample means for each sample size.
4. Compare simulated and theoretical means and standard errors where theoretical values exist.
5. Calculate skewness and excess kurtosis.
6. Produce histograms and normal Q-Q plots.
7. Summarize how the sampling distribution changes as the sample size increases.

The Cauchy analysis is handled separately because its ordinary mean and variance do not exist. The usual finite-variance standard-error comparison is therefore not applicable.

## Requirements

Install the following software:

- R
- RStudio
- Quarto

The analyses use base R functions and do not require additional R packages.

## Directory Structure

```text
project1/
├── 01_standard_normal.qmd
├── 02_six_sided_die.qmd
├── 03_exponential.qmd
├── 04_binomial_small.qmd
├── 05_cauchy.qmd
├── project1_helpers.R
├── final_summary.qmd
├── ai_prompts.md
├── README.md
└── extra_credit/
    ├── 06_dependent_machine_failure.qmd
    ├── 07_non_identical_bernoulli.qmd
    └── 08_life_death_population.qmd
```

The helper file must remain in the repository root. The files in `extra_credit/` reference it using:

```r
source("../project1_helpers.R")
```

The analyses in the repository root reference it using:

```r
source("project1_helpers.R")
```

## Reproducibility

Each simulation uses a fixed seed. To reproduce a specific run, keep the seed unchanged. To perform a sensitivity check, change the seed and compare the resulting numerical summaries and plots.

The exact simulated values may change slightly when the seed changes, but broader conclusions should remain similar when the number of repetitions is sufficiently large.

## Running the Analyses

Open the repository root in RStudio or a terminal before running the commands below.

### Render an individual analysis

```bash
quarto render 01_standard_normal.qmd
quarto render 02_six_sided_die.qmd
quarto render 03_exponential.qmd
quarto render 04_binomial_small.qmd
quarto render 05_cauchy.qmd
```

### Render the additional analyses

```bash
quarto render extra_credit/06_dependent_machine_failure.qmd
quarto render extra_credit/07_non_identical_bernoulli.qmd
quarto render extra_credit/08_life_death_population.qmd
```

### Render the summary

```bash
quarto render final_summary.qmd
```

Each command creates an HTML file beside the corresponding QMD file. The HTML output includes the generated tables, histograms, Q-Q plots, and written interpretation.

## Running from RStudio

1. Open the repository folder in RStudio.
2. Open the desired `.qmd` file.
3. Confirm that the helper file is in the expected location.
4. Select **Render** in the editor toolbar.
5. Review the generated HTML output.

## Interpreting Results

The analyses use multiple indicators rather than relying on a single normality rule:

- Histograms show the overall shape of the sampling distribution.
- Q-Q plots show how closely the simulated values follow a normal reference line.
- Skewness measures asymmetry.
- Excess kurtosis measures tail weight relative to a normal distribution.
- Simulated and theoretical means show whether the center agrees with expectation.
- Simulated and theoretical standard errors show whether the spread agrees with expectation.
- Quantiles help identify unusually wide or unstable tails.

Results should be interpreted in the context of the population's shape and assumptions. Dependence, changing observation distributions, heavy tails, and missing finite moments require additional care.

## Outputs

Rendered HTML files are generated beside their source QMD files. They can be committed to version control so that the generated tables, plots, and interpretations can be viewed without rerunning the simulations.
