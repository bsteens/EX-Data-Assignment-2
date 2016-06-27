setwd("~/Desktop/Coursera/EX Data 2/EX Data Assignment 2")

## read data

PMdata <- readRDS("summarySCC_PM25.rds")
PMcodes <- readRDS("Source_Classification_Code.rds")

length(PMdata$Emissions)

length(PMdata$year)

tot.PM25yr <- tapply(PMdata$Emissions, PMdata$year, sum)

## plot to png

png("plot1.png")
plot(names(tot.PM25yr), tot.PM25yr, type="l", xlab = "Year", ylab = expression
     ("Total" ~ PM[2.5] ~"Emissions (tons)"), main = expression("Total US" ~ 
                                                                        PM[2.5] ~ "Emissions by Year"), col="Purple")
dev.off()

