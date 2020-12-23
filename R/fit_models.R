#' Fit many regression models based on a vector of formulas 
#' 
#' @param formulas A vector of \code{formulas}. 
#' @param fitter fitting function or vector of fitting functions (default: \code{lm}). 
#' @param ... other arguments passed to fitting function. 
#' @param output Return estimated models in a list? 
#' @param print Print a regression table?
#' @param texreg A named list with arguments passed to \code{screenreg} if \code{print=TRUE}.
#' 
#' @return either \code{NULL} or the list of fitted model objects.
#' 
#' @details 
#' This simple function estimates a series of regression models based on a vector of formulas. 
#' The argument \code{fitter} allows to call any formula-based fitting function in R (e.g., lm, glm).
#' The function provides options to summarize the regressions in a regression table and/or to store 
#' the fit objects in a named list which can passed on.
#' 
#' @seealso 
#' \code{\link[texreg]{screenreg}}
#' 
#' @examples 
#' 
#' data(mtcars)
#' 
#' f_lm <- c(
#' 	mpg ~ vs, 
#' 	hp ~ vs, 
#' 	disp ~ vs * am)
#' 
#' fit_models(f_lm, fitter=lm, data=mtcars, 
#' 	output=FALSE, print=TRUE)
#' 
#' f_glm <- c(
#' 	vs ~ mpg, 
#' 	am ~ mpg)
#' 
#' mods <- fit_models(f_glm, fitter=glm, data=mtcars, 
#' 	family=binomial('logit'), 
#' 	output=TRUE, print=TRUE, 
#' 	texreg=list(stars=NULL))
#' 
#' lapply(mods, nobs)
#' 
#' 
#' 
#' @importFrom texreg screenreg
#' @export
fit_models <- function(formulas, fitter=lm, ...,  
		output=FALSE, print=TRUE, texreg=list()){

	K <- length(formulas)
	if(length(fitter)==1){
		fitter <- replicate(K, fitter)
	}
	l <- mapply( function(formula,model) {
			model(formula=formula, ...)
			}, formulas, fitter, SIMPLIFY=FALSE)
	dv <- lapply(formulas, function(f) as.character(f)[2] )
	names(l) <- dv

	if(print){
	print(
		do.call(
			screenreg, 
				c(list(l=l,custom.model.names = unlist(dv)), 
					texreg)
			)
		)
	}

	if(output) return(l)
	}




