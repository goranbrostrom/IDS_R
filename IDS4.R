ids4 <- function(){
    ## ----setup, include=FALSE------------------------------------------------
    ##knitr::opts_chunk$set(cache=TRUE,  echo=TRUE)
    library(eha)
    
    ## ----download------------------------------------------------------------
    library(haven)
    chronicle <- read_dta("ESHD16/Chronicle.dta")
    varsetup <- read_dta("ESHD16/VarSetup.dta")
    ## ----thechron------------------------------------------------------------
    ##print(head(chronicle))
    ##print(varsetup)
    ## return(varsetup)
    fixed.var <- varsetup$Type[varsetup$Transition == "Invariant"]

    personal <- chronicle[chronicle$Type %in% fixed.var, ]
    bl <- personal$Value == ""
    personal$Value[bl] <- with(personal[bl, ],
                               paste(Year, Month, Day, sep = "-"))
    personal$Year <- NULL
    personal$Month <- NULL
    personal$Day <- NULL
    personal$DayFrac <- NULL


  
    ##print(summary(personal))
    chronicle1 <- chronicle[!(chronicle$Type %in% fixed.var), ]
    return(chronicle1)
    ## ----sumchron------------------------------------------------------------
    ##print(summary(chronicle))
    
    ## ----tabla, echo=FALSE---------------------------------------------------
    ##print(with(chronicle, table(Type)))
    return(personal)
    ## ----headchron-----------------------------------------------------------
    head(chronicle)
    
    ## ----newc----------------------------------------------------------------
    (nv <- unique(chronicle$Type))
    chronicle[, nv] <- NA
    head(chronicle)
    
    ## ----manipulate----------------------------------------------------------
    names(chronicle)[1] <- "id"
    library(dplyr)
    chronicle <- arrange(chronicle, id, Date)
    starting <- arrange(starting, id) # Only one record per id.
    
    ## ----recnum--------------------------------------------------------------
    source("R/rc.R")
    chronicle <- rc(chronicle)
    head(chronicle)
    
    ## ----birthdate-----------------------------------------------------------
    source("R/tillTid.R")
    indx <- match(chronicle$id, starting$id)
    chronicle$birthdate <- starting$birthdate[indx]
    chronicle$exit <- tillTid(chronicle$Date) - tillTid(chronicle$birthdate)
    chronicle$enter <- c(NA, chronicle$exit[-NROW(chronicle)])
    chronicle$enter[chronicle$lopnr == 1] <- tillTid(starting$Date) - tillTid(starting$birthdate) # dangerous!
    head(chronicle)
    
    ## ----startv--------------------------------------------------------------
    stvar <- nv[nv %in% names(starting)]
    chronicle[, stvar] <- starting[indx, stvar]
    episodes <- chronicle
    head(episodes)
    
    ## ----goon----------------------------------------------------------------
    if (file.exists("episodes.rda")){
        load("episodes.rda")
    }else{
        source("R/fill.R")
        episodes <- fill(episodes)
        save(episodes, file = "episodes.rda")
    }
    
    ## ----lookalike-----------------------------------------------------------
    head(episodes)
    summary(episodes)
    
    ## ----removal-------------------------------------------------------------
    weq <- unique(episodes$id[is.na(episodes$enter) | episodes$enter < 0])
    episodes <- episodes[!(episodes$id %in% weq), ] 
    summary(episodes)
    
    ## ----missex--------------------------------------------------------------
    id <- episodes$id[is.na(episodes$exit)]
    episodes[episodes$id %in% id, ]
    
    ## ----quick---------------------------------------------------------------
    episodes = episodes[!is.na(episodes$exit), ]
    
    ## ----nonpos--------------------------------------------------------------
    (nonpos <- sum(episodes$enter >= episodes$exit))
    
    ## ----remthem-------------------------------------------------------------
    episodes <- episodes[episodes$exit > episodes$enter, ]
    dim(episodes)
    length(unique(episodes$id))
    
    ## ----fixedcov------------------------------------------------------------
    indx <- match(episodes$id, personal$id)
    vars <- names(personal)[-(1:2)]
    episodes[, vars] <- personal[indx, vars]
    head(episodes)
    
    ## ----remred--------------------------------------------------------------
                                        #episodes <- episodes[episodes$atRisk == 1, ]
    episodes$Date <- episodes$dead <- episodes$migration <- NULL
    episodes$lopnr <- episodes$antrec <- NULL
    
    
    ## ----vallab--------------------------------------------------------------
    episodes$Type <- as.factor(episodes$Type)
    episodes$sex <- factor(episodes$sex, labels = c("man", "woman"))
    summary(episodes)
    
    return(episodes)
    ## ----morta, cache=TRUE---------------------------------------------------
    episodes$exit <- as.numeric(episodes$exit)
    fit <- coxreg(Surv(enter, exit, Type == "dead") ~ sex, data = episodes)
    (dr <- drop1(fit, test = "Chisq"))
    fit
    
    ## ----deadplot, echo = FALSE----------------------------------------------
    fit <- coxph(Surv(enter, exit, Type == "dead") ~ strata(sex), data = episodes)
    plot(survfit(fit), mark.time = FALSE, col = c("blue", "red"), xlab = "Age", 
         ylab = "Surviving fraction")
    text(25, 0.5, "Women", col = "red")
    text(55, 0.8, "Men", col = "blue")
    abline(h = 0)
    
    ## ----fertility-----------------------------------------------------------
    fit <- coxph(Surv(enter, exit, Type == "childBirth") ~ strata(sex), data = episodes)
    plot(survfit(fit), mark.time = FALSE, fun = "cumhaz", col = c("blue", "red"),
         xlab = "Age", ylab = "No of births", xlim = c(16, 60))
    text(25, 3, "Women", col = "red")
    text(45, 3, "Men", col = "blue")
    abline(h = 0)
    
    ## ----firstbi, cache = TRUE-----------------------------------------------
    fit <- coxph(Surv(enter, exit, Type == "childBirth") ~ civst + birthdate, 
                 data = episodes[episodes$sex == "woman" & episodes$childBirth == 1, ])
    summary(fit)
    plot(survfit(fit), mark.time = FALSE, xlab = "Age", xlim = c(17, 40), col = "blue")
    abline(h = 0)
    
    ## ----firstiv, cache = TRUE-----------------------------------------------
    first <- episodes[episodes$sex == "woman" & 
                      episodes$childBirth == 1 &
                      episodes$civst %in% 1:3, ]
    first$civst <- factor(first$civst, labels = c("unmarried", "married", "widow"))
    
    indx <- with(first, tapply(id, id))
    minEnter <- with(first, tapply(enter, id, min))
    minEnter <- minEnter[indx]
    first$enter <- first$enter - minEnter
    first$exit <- first$exit - minEnter
    head(first[, c("id", "enter", "exit", "Type")])
    
    ## ---- firstivsk, cache = TRUE--------------------------------------------
    fit <- coxph(Surv(enter, exit, Type == "childBirth") ~ strata(civst), data = first)
    plot(survfit(fit), fun = "cumhaz", col = c("blue", "red", "black"), 
         mark.time = FALSE, xlim = c(0, 10), xlab = "Years", ylab = "Cumulative hazards", 
         main = "First birth interval")
    text(2, 2.5, "married", col = "red")
    text(5, 1.0, "widowed", col = "black")
    text(7, 0.5, "unmarried", col = "blue")
    abline(h = 0)
}
