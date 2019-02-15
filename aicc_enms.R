## Function to calculate AICc for multiple Ecological Niche Models at once.
#                                           Micael Parreira, February 2019


# For details on inputs of this function, please read the readme file in the repository.

AICc_enm <- function(suits, suits_pts, n_pars){
  if(length(n_pars) != dim(suits)[2]){
    stop('Number of parameters used must be the same as the number of models')
  }
  if(ncol(suits_pts) != ncol(suits)){
    stop('Number of suitability columns of points must be the same as models')
  }
  if (!(is(suits, "data.frame"))) {
    stop("Suitability values must be in at least 1 column of a data.frame object")
  }
  if (!(is(suits_pts, "data.frame"))) {
    stop("Suitability values must be in at least 1 column of a data.frame object")
  }
  if (!(is.numeric(n_pars))) {
    stop("Number of parameters must be a numeric object")
  }
  log_suits <- matrix(0, ncol = ncol(suits_pts), nrow = nrow(suits_pts))
  suits_sum <- like <- aic_p1 <- aic_p2 <- aic_p3 <- aic_res <- numeric()
  model_names <- character()
  n_pts <- nrow(suits_pts)
  for(i in 1:dim(suits_pts)[1]){
    for(j in 1:dim(suits_pts)[2]){
      suits_sum[j] <- sum(suits[,j])
      log_suits[i,j] <- log10(suits_pts[i,j] / suits_sum[j])
      like[j] <- sum(log_suits[,j])
      aic_p1[j] <- (2*n_pars[j]) - (2*like[j]) 
      aic_p2[j] <- (2*n_pars[j]) * (n_pars[j]+1)
      aic_p3[j] <- (n_pts-n_pars[j]-1)
      aic_res[j] <- aic_p1[j] + (aic_p2[j] / aic_p3[j])
      model_names[j] <- colnames(suit.pts[j])
    }
  }
  aic_delta <- aic_res / min(aic_res)
  aic_delta[which.min(aic_delta)] <- 0
  exp_aic <- exp(-0.5 * aic_delta)
  aic_w <- exp_aic / sum(exp_aic)
  resu <- data.frame(AICc= round(aic_res, 1), DeltaAIC = round(aic_delta[,1], 2),
                     AICw = round(aic_w[,1], 2), Parameters = n_pars,
                     row.names = model_names)
  return(resu)
}

AICc_enm(suit.ens, suit.pts, n_pars = c(3,5))
