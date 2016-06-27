setwd("~/Desktop/Coursera/EX Data 2/EX Data Assignment 2")

library(ggplot2)
library(plyr)
library(grid)

## read data

PMdata <- readRDS("summarySCC_PM25.rds")
PMcodes <- readRDS("Source_Classification_Code.rds")

## check levels for types of vehicles defined

mv.sourced <- unique(grep("Vehicles", PMcodes$EI.Sector, ignore.case = TRUE, value = TRUE))

mv.sourcec <- PMcodes[PMcodes$EI.Sector %in% mv.sourced, ]["SCC"]


## subset the data Baltimore City

emMV.ba <- PMdata[PMdata$SCC %in% mv.sourcec$SCC & PMdata$fips == "24510", ]

## subset the data Los Angeles County

emMV.LA <- PMdata[PMdata$SCC %in% mv.sourcec$SCC & PMdata$fips == "06037", ]

## bind the data created 

emMV.comb <- rbind(emMV.ba, emMV.LA)

## Find the emmissions due to motor vehicles in 
## Baltimore and Los Angeles County

tmveYR.county <- aggregate (Emissions ~ fips * year, data =emMV.comb, FUN = sum ) 
tmveYR.county$county <- ifelse(tmveYR.county$fips == "06037", "Los Angeles", "Baltimore")

## plot to png

png("plot6.png", width=750)
k <- qplot(year, Emissions, data=tmveYR.county, geom="line", color=county) + 
        ggtitle(expression("Motor Vehicle Emission Levels" ~ PM[2.5] ~ "  from 1999 to 2008 in Los Angeles County, CA and Baltimore, MD")) + 
        xlab("Year") + ylab(expression("Levels of" ~ PM[2.5] ~ " Emissions"))

print(k)

dev.off()