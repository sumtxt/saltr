Saltr
================

Spicing up your model soup!

Fit many regression models based on a vector of formulas and a fitting
function. Minimal dependencies (only
[leifeld/texreg](https://github.com/leifeld/texreg)). Should work with
any formula-based fitting function.

``` r
library(saltr)
data(mtcars)

f_lm <- c(
  mpg ~ vs, 
  hp ~ vs, 
  disp ~ vs * am)

fit_models(f_lm, fitter=lm, data=mtcars, 
  output=FALSE, print=TRUE)
#> 
#> ===============================================
#>              mpg        hp          disp       
#> -----------------------------------------------
#> (Intercept)  16.62 ***  189.72 ***   357.62 ***
#>              (1.08)     (11.35)      (18.80)   
#> vs            7.94 ***  -98.37 ***  -182.50 ***
#>              (1.63)     (17.16)      (30.97)   
#> am                                  -151.40 ***
#>                                      (32.55)   
#> vs:am                                 66.09    
#>                                      (47.65)   
#> -----------------------------------------------
#> R^2           0.44        0.52         0.75    
#> Adj. R^2      0.42        0.51         0.72    
#> Num. obs.    32          32           32       
#> ===============================================
#> *** p < 0.001; ** p < 0.01; * p < 0.05


f_glm <- c(
  vs ~ mpg, 
  am ~ mpg)

mods <- fit_models(f_glm, 
  fitter=glm, data=mtcars, 
  family=binomial('logit'), 
  output=TRUE, print=TRUE)
#> 
#> ====================================
#>                 vs         am       
#> ------------------------------------
#> (Intercept)      -8.83 **   -6.60 **
#>                  (3.16)     (2.35)  
#> mpg               0.43 **    0.31 **
#>                  (0.16)     (0.11)  
#> ------------------------------------
#> AIC              29.53      33.68   
#> BIC              32.46      36.61   
#> Log Likelihood  -12.77     -14.84   
#> Deviance         25.53      29.68   
#> Num. obs.        32         32      
#> ====================================
#> *** p < 0.001; ** p < 0.01; * p < 0.05
```

### Installation

``` r
# Install development version from GitHub
remotes::install_github("sumtxt/saltr")
```
