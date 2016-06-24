# This fiel creates 13 objects
# [1] "baselineSummary" "carMiles"        "co2data"         "death"
# [5] "idata"           "milesCycled"     "sdata"           "temp"
# [9] "tp_mode"         "tripMode"        "tripTime"        "yll"
#[ 13] "yll_red"

# idata: A data frame created from mmets_var.csv

# "ID","baseline_mmet","MS2_ebik0_eq0","MS4_ebik0_eq0","MS8_ebik0_eq0","MS16_ebik0_eq0","MS32_ebik0_eq0","MS64_ebik0_eq0","MS2_ebik0_eq1","MS4_ebik0_eq1","MS8_ebik0_eq1","MS16_ebik0_eq1","MS32_ebik0_eq1","MS64_ebik0_eq1","MS2_ebik1_eq0","MS4_ebik1_eq0","MS8_ebik1_eq0","MS16_ebik1_eq0","MS32_ebik1_eq0","MS64_ebik1_eq0","MS2_ebik1_eq1","MS4_ebik1_eq1","MS8_ebik1_eq1","MS16_ebik1_eq1","MS32_ebik1_eq1","MS64_ebik1_eq1","age_group","Sex_B01ID","EthGroupTS_B02ID","NSSec_B03ID","MainMode_Reduced"

# sdata: A data frame created from ICT_aggr.csv

# FileName,MS,ebike,equity,% of trips by bicycle,% cyclists in the total population,Miles cycled per person per week,Car miles cycled  per week,Marginal METs per person per week,Years of Life Lost (YLL),Car miles per person per week,Car miles reduced per person per week,CO2 (kg) from car travel per person per week

# baselineSummary: The first row of sdata

# tp_mode: a data frame mapping transport mode to transport mode code

# yll, death, yll_red: data frames created from yll_agg_u.csv, death_agg_u.csv, yll_red_agg_u.csv

# carMiles: a data frame created from carMiles_var1.csv

# "ID","baseline_carMiles","MS2_ebik0_eq0","MS4_ebik0_eq0","MS8_ebik0_eq0","MS16_ebik0_eq0","MS32_ebik0_eq0","MS64_ebik0_eq0","MS2_ebik0_eq1","MS4_ebik0_eq1","MS8_ebik0_eq1","MS16_ebik0_eq1","MS32_ebik0_eq1","MS64_ebik0_eq1","MS2_ebik1_eq0","MS4_ebik1_eq0","MS8_ebik1_eq0","MS16_ebik1_eq0","MS32_ebik1_eq0","MS64_ebik1_eq0","MS2_ebik1_eq1","MS4_ebik1_eq1","MS8_ebik1_eq1","MS16_ebik1_eq1","MS32_ebik1_eq1","MS64_ebik1_eq1","age_group","Sex_B01ID","EthGroupTS_B02ID","NSSec_B03ID","MainMode_Reduced"

# milesCycled:

# tripMode:

# tripTime:

# co2data:

# temp:

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
