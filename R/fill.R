fill <- function(dat){
    
    for (id in unique(dat$id)){
        x <- dat[dat$id %in% id, ,drop = FALSE]
        n <- NROW(x)
        if (n > 1){
            for (j in 2:n){
                x[j:n, x$Type[j-1]] <- x[j-1, "Value"]
            }
            dat[dat$id %in% id, ] <- x
        }
    }
    dat
}