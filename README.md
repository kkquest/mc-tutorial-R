# ___README___

## Noise-Busters: How to Sharpen Your Monte Carlo

![R](https://img.shields.io/badge/R-4.3.1-blue.svg)
![renv](https://img.shields.io/badge/renv-locked-orange.svg)
![MIT License](https://img.shields.io/badge/License-MIT-green.svg)

A hands-on tutorial on variance-reduction techniques for Monte Carlo sampling: 
antithetic sampling, control variates, and importance sampling.  
Perfect for master’s students and practitioners who already know basic Monte Carlo 
but want to crush variance (and compute time) on real-world problems.


---

## Overview

Standard Monte Carlo converges at only $O(1/\sqrt{n})$. 
For rare events or “spiky” integrands, naïve sampling can demand millions
(or billions!) of draws to see tight confidence intervals.

Noise-Busters Tutorial shows you three powerful tricks that deliver the same 
(or better) precision with far fewer simulations:

1. **Antithetic Sampling**  
2. **Control Variates**  
3. **Importance Sampling**

Each technique is introduced conceptually, implemented in R, 
and compared side-by-side with timing and sampling-variance benchmarks.

By working through this tutorial, you will learn to:
- Implement and compare antithetic sampling, control variates, and importance sampling
- Diagnose convergence with CI plots  

## 🚀 Quickstart

1. **Clone the repo**. In your terminal run:
   ```bash
   git clone https://github.com/kkquest/mc-tutorial-R.git
   cd noise-busters
   ```

2. **Restore R package library**. For this, in your R console run:

    ```r
    renv::restore()
    ```
   
3. **Render the tutorial using R console**

    ```r
    # Render it
    quarto::quarto_render("notebooks/variance_reduction.qmd") 
    
    # Open it
    rstudioapi::viewer("notebooks/variance_reduction.html") 
    
    # If you don't have Quarto, install it
    quarto::install_quarto() # Downloads & installs the CLI
    ```

    
## Project Structure

```r
├── LICENSE                                 # MIT license text
├── README.md                               # this file (tutorial overview + setup instructions)  
├── README.html                             # rendered HTML version of README
├── renv.lock                               # locked R package versions for reproducibility 
└── .gitignore                              # ignores caches, renv/lib, OS cruft
└── .Rprofile                               # auto-activate renv
└── mc-tutorial-R.Rproj                     # RStudio project file
├── R/                                      # all R helper scripts
│   ├── simulations.R                       # rare_event_standard(), sim_antithetic(), sim_y_cv(), sim_x_cv()
│   ├── variance_reduction_methods.R        # antithetic_mc(), control_variate_mc(), importance_mc()
│   ├── confidence_intervals.R              # ci_df()
│   ├── true_value.R                        # true_estimate
│   └── plotting.R                          # plot_estimates()
├── outputs/                                # generated tables & CSVs
├── notebooks/                              # Quarto tutorial & its cache
│   ├── variance_reduction.qmd              # Main tutorial file
│   ├── variance_reduction.html             # Rended tutorial
│   ├── variance_reduction_files            # Quarto cache (figures, etc.) 
│   ├── variance_reduction_cache            # Supporting files for HTML  
├── docs/                                   # Project-level docs
│   ├── summary-template.tex                # Effective summary of this project
````

## R Session Setup
At the top of each chunk, we load the libraries:

    ```r
    library(ggplot2)    # for plots
    library(withr)      # for reproducible seeds
    library(knitr)      # for nice tables
    
    source("R/simulations.R")
    source("R/variance_reduction_methods.R")
    source("R/confidence_intervals.R")
    source("R/true_value.R")
    source("R/plotting.R")
    ```
We use `withr::local_seed()` in each example chunk so that t
he same numbers appear every time you render.

We also set `cache=TRUE` for computationally intensive chunks 
to avoid rerunning hundreds of thousands of samples on every rebuild.

## Usage 

Once rendered, the tutorial walks you through:

      Section 1: Do You Know Your Monte Carlo?
      
      Section 2.1: When Standard Monte Carlo falters
      
      Section 2.2: Why so many samples?
      
      Section 2.3: Monte Carlo Chaos: Simple Example
      
      Section 3.1 Standard MC as a Baseline
      
      Section 3.2 Antithetic Sampling
      
      Section 3.3 Control Variates
      
      Section 3.4 Importance Sampling
            
      Section 4.1: Final Side‑by‑Side Comparison
      
      Section 4.2: Final Takeaways
      
      Section 5: Wrapping Up
  
At each step you’ll see clear plots and commentary on when to reach for each method in your own projects.

## License

This tutorial is released under the MIT License. See `LICENSE` for details.

## Recommendations for Future Extensions

1. **Keep code well-commented with roxygen2 syntax**  
   We’ve added `#'` comments to every function in `R/*.R` so you can see 
   at a glance what each does, what inputs it needs, and what it returns. 
   Maintaining this style helps new contributors or your future self 
   pick up the code quickly, whether you’re working in an IDE or generating help files.

2. **Checkpoint long simulations**  
   If you scale these Monte Carlo methods to very large datasets or higher `n_sims`, 
   wrap your loops in a function that periodically writes interim results 
   (e.g. every 10 000 iterations) to disk. 
   This lets you restart from the last checkpoint after a crash or timeout 
   and preserves days of compute work.


## Acknowledgments & Citation

If you find this tutorial useful, please rate the repo on GitHub and cite it as:

Noise-Busters: How to Sharpen Your Monte Carlo
Your Name (2025). GitHub repository: https://github.com/kkquest/mc-tutorial-R

### **Happy variance-busting! 🚀**