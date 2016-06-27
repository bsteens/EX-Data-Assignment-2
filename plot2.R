setwd("~/Desktop/Coursera/EX Data 2/EX Data Assignment 2")

## read data

PMdata <- readRDS("summarySCC_PM25.rds")
PMcodes <- readRDS("Source_Classification_Code.rds")

## subsets to plot

baltimore <- subset (PMdata, fips == "24510")
tot.PM25yr <- tapply(baltimore$Emissions, baltimore$year, sum)

##  plot to png

png("plot2.png")
plot(names(tot.PM25yr), tot.PM25yr, type = "l", xlab="Year", ylab= expression("Total" ~ PM[2.5] ~ "Emissions (tons)")
     , main=expression("Total for Baltimore City" ~ PM[2.5] ~ "Emissions by Year"), col = "blue")
dev.off()  

