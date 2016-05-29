rc <- function(dat){
    if (is.null(dat$id)){
        if (is.null(dat$ID)){
            stop("Missing 'id' or 'ID'")
        }else{
            dat <- dat[order(dat$ID), ]
            dat$lopnr <- unlist(with(dat,
                                     tapply(ID, ID, function(x) 1:length(x))))
            indx <- tapply(dat$ID, dat$ID)
            dat$antrec <- tapply(dat$ID, dat$ID, length)[indx]
        }
    }else{
        dat <- dat[order(dat$id), ]
        dat$lopnr <- unlist(with(dat,
                                 tapply(id, id, function(x) 1:length(x))))
        indx <- tapply(dat$id, dat$id)
        dat$antrec <- tapply(dat$id, dat$id, length)[indx]
    }
    dat
}
