setwd("~/Desktop/Coursera/EX Data 2/EX Data Assignment 2")

library(ggplot2)
library(plyr)

## read data

PMdata <- readRDS("summarySCC_PM25.rds")
PMcodes <- readRDS("Source_Classification_Code.rds")

## subset data
mv.sourced <- unique(grep("Vehicles", PMcodes$EI.Sector, ignore.case = TRUE, value = TRUE))

mv.sourcec <- PMcodes[PMcodes$EI.Sector %in% mv.sourced, ]["SCC"]


emMV.ba <- PMdata[PMdata$SCC %in% mv.sourcec$SCC & PMdata$fips == "24510",]

## find the emissions due to motor vehicles in Baltimore for every year
balmv.pm25yr <- ddply(emMV.ba, .(year), function(x) sum(x$Emissions))
colnames(balmv.pm25yr)[2] <- "Emissions"

## Step 4: Plot to png
png("plot5.png")
t <- qplot(year, Emissions, data=balmv.pm25yr, geom="line") + 
        ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) + 
        xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
print(t)
dev.off()