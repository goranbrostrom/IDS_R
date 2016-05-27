toYear <- function(Day, Month, Year){
   library(eha)
   stri <- ifelse(is.na(Year), NA, paste(Year, Month, Day, sep = '-'))
   toTime(stri)
}