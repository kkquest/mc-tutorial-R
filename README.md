# Monte Carlo Tutorial in R

This repository contains an end-to-end Monte Carlo tutorial—estimating π, variance-reduction techniques, and a real-world VaR demo via Shiny.  
See the live tutorial page on Notion: [your-link-here].  

## Structure

- `R/` : source functions (`engine.R`, `problems.R`, `vr_methods.R`)  
- `notebooks/` : Quarto documents (`.qmd`) for each step  
- `docs/` : reflective summary template & output  
- `renv.lock` : package snapshot

## Getting Started

1. Clone the repo  
2. In R:
   ```r
   renv::restore()
   quarto render notebooks/*.qmd
   ```
   
## TODO

- [ ] Add installation instructions for Quarto and R packages  
- [ ] Link to live Notion tutorial page  
- [ ] Document Shiny app deployment steps  
- [ ] Provide example outputs (screenshots/GIFs)

