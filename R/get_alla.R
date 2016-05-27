get_alla <- function(dat = chron){
    ## Calls 'get_chronicle' for each distinct value of dat$ID
    ## and joins the results.
    source("R/get_chronicle.R")
    alla <- data.frame(id = numeric(0), Variable = character(0), Value = numeric(0), atRisk = numeric(0))
    for (id in unique(dat$ID)){
        ##cat("ID = ", id, "\n")
        alla <- rbind(alla, get_chronicle(dat[dat$ID == id, ]))
    }
    alla
}