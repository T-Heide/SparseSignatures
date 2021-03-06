% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/signatures.discovery.lasso.R
\name{nmfLasso}
\alias{nmfLasso}
\title{nmfLasso}
\usage{
nmfLasso(
  x,
  K,
  beta = NULL,
  background_signature = NULL,
  normalize_counts = TRUE,
  nmf_runs = 10,
  lambda_rate_alpha = 0.05,
  lambda_rate_beta = 0.05,
  iterations = 30,
  max_iterations_lasso = 10000,
  seed = NULL,
  verbose = TRUE
)
}
\arguments{
\item{x}{count matrix for a set of n patients and 96 trinucleotides.}

\item{K}{numeric value (minimum 2) indicating the number of signatures to be discovered.}

\item{beta}{starting beta for the estimation. If it is NULL, starting beta is estimated by NMF.}

\item{background_signature}{background signature to be used. If not provided, a warning is thrown and an initial value for it is 
estimated by NMF. If beta is not NULL, this parameter is ignored.}

\item{normalize_counts}{if true, the input count matrix x is normalize such that the patients have the same number of mutation.}

\item{nmf_runs}{number of iteration (minimum 1) of NMF to be performed for a robust estimation of starting beta. If beta is not NULL, 
this parameter is ignored.}

\item{lambda_rate_alpha}{value of LASSO to be used for alpha between 0 and 1. This value should be greater than 0. 1 is the value of LASSO 
that would shrink all the exposure values to 0 within one step. The higher lambda_rate_alpha is, the sparser are the resulting exposure values, 
but too large values may result in a reduced fit of the observed counts.}

\item{lambda_rate_beta}{value of LASSO to be used for beta between 0 and 1. This value should be greater than 0. 1 is the value of LASSO 
that would shrink all the signatures to 0 within one step. The higher lambda_rate_beta is, the sparser are the resulting signatures, 
but too large values may result in a reduced fit of the observed counts.}

\item{iterations}{Number of iterations to be performed. Each iteration corresponds to a first step where beta is fitted 
and a second step where alpha is fitted.}

\item{max_iterations_lasso}{Number of maximum iterations to be performed during the sparsification via Lasso.}

\item{seed}{Seed for reproducibility.}

\item{verbose}{boolean; Shall I print all messages?}
}
\value{
A list with the discovered signatures. It includes 6 elements: 
             alpha: matrix of the discovered exposure values
             beta: matrix of the discovered signatures
             starting_alpha: initial alpha on which the method has been applied
             starting_beta: initial beta on which the method has been applied
             loglik_progression: log-likelihood values during the iterations. This values should be increasing, if not the selected value of lambda is too high
             best_loglik: log-likelihood of the best signatures configuration
}
\description{
Perform the discovery of K somatic mutational signatures given a set of observed counts x.
}
\examples{
data(patients)
data(starting_betas_example)
beta = starting_betas_example[["5_signatures","Value"]]
res = nmfLasso(x=patients[1:100,],
     K=5,
     beta=beta,
     lambda_rate_alpha=0.05,
     lambda_rate_beta=0.05,
     iterations=5,
     seed=12345)

}
