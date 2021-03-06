library(stringr)

idata <- read.csv("data/csv/mmets_var.csv", as.is = T)

sdata <- read.csv("data/csv/ICT_aggr.csv", header = T, check.names=FALSE)

baselineSummary <- sdata[1,]
# Temporarily remove baseline summary
sdata <- sdata[-1,]
sdata[is.na(sdata)] <- 0

# Create a lookup table for mode of transport
tp_mode <- data.frame (mode = c("Walk", "Bicycle", "Ebike", "Car Driver", "Car Passenger", "Bus", "Train", "Other"), code = c(1, 2, 2.5, c(3:7)))

# # Read Health Calculations
yll <- read.csv("data/csv/yll_agg_u.csv", header = T, as.is = T)
death <- read.csv("data/csv/death_agg_u.csv", header = T, as.is = T)
yll_red <- read.csv("data/csv/yll_red_agg_u.csv", header = T, as.is = T)

#Read Car Miles data
carMiles <- read.csv("data/csv/carMiles_var1.csv", header = T, as.is = T)
carMiles[is.na(carMiles)] <- 0

milesCycled <- read.csv("data/csv/milesCycled.pers_var1.csv", header = T, as.is = T)
milesCycled[is.na(milesCycled)] <- 0

# #Read Trip data
#tripData <- read.csv("data/csv/tripsdf.csv", header = T, as.is = T)

# Read updated Trip data
tripMode <- read.csv("data/csv/tripsdf_updated.csv", header = T, as.is = T)

# Read trip time
tripTime <- read.csv("data/csv/triptime1.csv", header = T, as.is = T)

# Get row numbers with NA
temp <- data.frame(rn = which( is.na(tripMode$MainMode_Reduced), arr.ind=TRUE))

# Remove all rows with NA in them
tripMode <- (subset(tripMode, !(X %in% temp$rn) ))

tripTime <- (subset(tripTime, !(X %in% temp$rn) ))

# # "Walk", "Bicycle", "Ebike", "Car Driver", "Car Passenger", "Bus", "Train", "Other"
# # Reduce the number of modes to 4
# # walk, bicycle, car, others
# lookup <- data.frame(mode=c(1.0,2.0,2.5,3.0,4.0,5.0,6.0,7.0),red_mode=c(1.0,2.0,2.0,3.0,3.0,4.0,4.0,4.0))
# 
# # Replace number of modes in each of the scenarios and the baseline to 4
# for (i in 7:31){
#   tripMode[,i] <- lookup$red_mode[match(tripMode[,i], lookup$mode)]
# }

names(tripTime)[names(tripTime)=="MainMode_Reduced"] <- "baseline"

names(tripMode)[names(tripMode)=="MainMode_Reduced"] <- "baseline"

#Read CO2 data
co2data <- read.csv("data/csv/co2.csv", header = T, as.is = T)