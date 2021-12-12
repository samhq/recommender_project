# Movie Recommender Shiny App

## Authors

- Alex Scharf (`ascharf2`)
- Gazi Muhammad Samiul Hoque (`ghoque2`)
- Sanjay Athreya (`ssa5`)

## Introduction

This is a Movie Recommender App hosted at https://ghoque2.shinyapps.io/recommender_app/

This recommender app utilizes a dataset that contains about 1 million anonymous ratings of approximately 3,900 movies made by 6,040 MovieLens users who joined MovieLens in 2000. We propose two recommendation system, 

- Content-based recommendation (top rated movies by genre)
- Collaborative recommendation (item-based collaborative filtering)

## Setup and Run

Download/clone this repository, then open it in RStudio as a project.

Run the following code to install the required libraries:

```r
mypackages = c("shiny", "recommenderlab", "data.table", "shinyjs", "bslib", "stringr", "dplyr", "Matrix")

tmp = setdiff(mypackages, rownames(installed.packages()))
if (length(tmp) > 0)
  install.packages(tmp)
```

Then open `ui.R` or `server.R` and click `Run App` from the top.
