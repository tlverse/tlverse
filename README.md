<!-- README.md is generated from README.Rmd. Please edit that file -->
tlverse
=======

`tlverse` is an umbrella package for targeted learning in R.

`library(tlverse)` loads the following core packages:

-   [sl3](https://jeremyrcoyle.github.io/sl3/) for SuperLearning
-   [tmle3](https://jeremyrcoyle.github.io/tmle3/) for TMLE (Targeted Minimum Loss-based Estimation)

as well as the following helper packages:

-   [delayed](https://github.com/jeremyrcoyle/delayed) for parallelizing dependent tasks
-   [origami](https://github.com/jeremyrcoyle/origami) for cross-validation

and packages for individual tmle3 parameters:

*coming soon*

Installation
------------

The `tlverse` ecosystem of packages are currently hosted at
https://github.com/tlverse, not yet on [CRAN](http://cran.r-project.org/). You
can use the `devtools` package to install them:

```{r installation, eval=FALSE}
install.packages("devtools")
devtools::install_github("tlverse/tlverse")
```

The `tlverse` depends on a large number of other packages that are also hosted
on GitHub. Because of this, you may see the following error:

```
Error: HTTP error 403.
  API rate limit exceeded for 71.204.135.82. (But here's the good news:
  Authenticated requests get a higher rate limit. Check out the documentation
  for more details.)

  Rate limit remaining: 0/60
  Rate limit reset at: 2019-03-04 19:39:05 UTC

  To increase your GitHub API rate limit
  - Use `usethis::browse_github_pat()` to create a Personal Access Token.
  - Use `usethis::edit_r_environ()` and add the token as `GITHUB_PAT`.
```

This just means that R tried to install too many packages from GitHub in too
short of a window. To fix this, you need to tell R how to use GitHub as your
user (you'll need a GitHub user account). Follow these two steps:

1. Use `usethis::browse_github_pat()` to create a Personal Access Token.
2. Use `usethis::edit_r_environ()` and add the token as `GITHUB_PAT`.
