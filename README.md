# Aicc_enm
Function to calculate AICc for ENMs using suitability values outputs

Three inputs necessary to run this function:
1) A data.frame object with suitability values extracted of all grid cells (e.g. emsemble map) = suits
2) A data.frame object with suitability values extracted to each presence point (1 or +1 columns) = suit_pts
3) Number of parameters (environmental variables) used in the ENMs as a numeric object (e.g.: c(3,5) = (n_pars)

Obs:
- Number of presences must be the same to all models
- The number of parameters order must follow the same of the models in the data.frame objects
