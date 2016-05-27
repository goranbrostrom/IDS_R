creDate <- function(dat){
   ## Converts 'Day, Month, Year' to a 'Time' (eha::toTime)
   ## Similarly for 'Start_ and End_'
   library(eha)
   source("R/toYear.R")

   if (!is.null(dat$Start_day)){
      dat$startdate <- with(dat, toYear(Start_day, Start_month, Start_year))
      dat$Start_day <- dat$Start_month <- dat$Start_year <- NULL
   }
   if (!is.null(dat$End_day)){
      dat$enddate <- with(dat, toYear(End_day, End_month, End_year))
      dat$End_day <- dat$End_month <- dat$End_year <- NULL
   }
   if (!is.null(dat$Day)){
      dat$date <- with(dat, toYear(Day, Month, Year))
      dat$Day <- dat$Month <- dat$Year <- NULL
   }
   dat
}