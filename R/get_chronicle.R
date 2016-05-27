get_chronicle <- function(dat = chron){
    ## This is for one ID only
    
    n <- NROW(dat)
    n_out <- with(dat, sum(ch_civst, ch_socst, move_in, move_out))
    Variable <- character(n_out)
    Value <- numeric(n_out)
    Date <- numeric(n_out)
    atRisk <- rep(1, n_out)
    start <- 0
    slut <- 0
    ## civst:
    n_chcivst <- sum(dat$ch_civst)
    if (n_chcivst > 0){
        start <- 1
        slut <- slut + n_chcivst
        ##cat("slut1 = ", slut, "\n")
        Variable[start:slut] <- "civst"
        Value[start:slut] <- dat$next_civst[dat$ch_civst]
        Date[start:slut] <- dat$date[dat$ch_civst]
        atRisk[start:slut] <- 1 - dat$move_out[dat$ch_civst]
    }
    ## socst:
    n_chsocst <- sum(dat$ch_socst)
    if (n_chsocst > 0){
        start <- slut + 1
        slut <- start + n_chsocst  - 1
        ##cat("slut2 = ", slut, "\n")
        Variable[start:slut] <- "socst"
        Value[start:slut] <- dat$next_socst[dat$ch_socst]
        Date[start:slut] <- dat$date[dat$ch_socst]
        atRisk[start:slut] <- 1 - dat$move_out[dat$ch_socst]
    }
    
    ## Death:
    n_death <- sum(dat$dead)
    
    if(n_death > 0){
        start <- slut + 1
        slut <- start + n_death - 1
        Variable[start:slut] <- "dead"
        Value[start:slut] <- 1
        Date[start:slut] <- dat$date[dat$dead]
        atRisk[start:slut] <- 0
    }
    
    ## Migration:
    #(a) Out:
    
    n_out <- sum(dat$move_out)
    
    if (n_out > 0){
        start <- slut + 1
        slut <- start + n_out - 1
        Variable[start:slut] <- "migration"
        Value[start:slut] <- -1 # Move out; 'one person lost'
        Date[start:slut] <- dat$date[dat$move_out]
        atRisk[start:slut] <- 0
    }
    
    # (b) In:
    
    n_in <- sum(dat$move_in)
    
    if (n_in > 0){
        start <- slut + 1
        slut <- start + n_in - 1
        Variable[start:slut] <- "migration"
        Value[start:slut] <- 1 # Move in; 'one person gained'
        Date[start:slut] <- dat$date[dat$move_in]
        atRisk[start:slut] <- 1
    }
    
    
    if (slut > 0){
        ##cat("Final: slut = ", slut, "\n")
        ret <- data.frame(id = rep(dat$ID[1], slut), Variable = Variable[1:slut], Value = Value[1:slut], 
                          Date = Date[1:slut], atRisk = atRisk[1:slut])
        ret <- ret[order(ret$Date, -ret$atRisk), ]
        ##cat("dim(ret) = ", dim(ret), "\n" )
    }else{
        ret <- NULL
    }
    ret
}