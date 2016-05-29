tillTid <- function(x){
    ##require(eha)
    out <- (is.na(x) | (as.numeric(x) < 16000000)) # Born before 1600
    ## x is on the form yyyymmdd
    ##cat("x = ", x, "\n")
    x <- as.character(x)
    year <- substr(x, 1, 4)
    month <- substr(x, 5, 6)
    day <- substr(x, 7, 8)
    month <- ifelse(as.numeric(month) > 12.5, "12", month)
    day <- ifelse ((month == "02") & (as.numeric(day) > 28), "28", day)
    day <- ifelse ((month == "04") & (as.numeric(day) > 30), "30", day)
    day <- ifelse ((month == "06") & (as.numeric(day) > 30), "30", day)
    day <- ifelse ((month == "09") & (as.numeric(day) > 30), "30", day)
    day <- ifelse ((month == "11") & (as.numeric(day) > 30), "30", day)
    y <- paste(year, month, day, sep = "-")
    x <- ifelse(out, NA, y)
    eha::toTime(x)
}
