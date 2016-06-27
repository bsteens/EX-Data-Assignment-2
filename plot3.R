setwd("~/Desktop/Coursera/EX Data 2/EX Data Assignment 2")

library(ggplot2)
library(plyr)

## read data

PMdata <- readRDS("summarySCC_PM25.rds")
PMcodes <- readRDS("Source_Classification_Code.rds")

## subset the data

baltimore <- subset (PMdata, fips == "24510")
typePM25.year <- ddply(baltimore, .(year, type), function(x) sum(x$Emissions))

## rename the col

colnames(typePM25.year)[3] <- "Emissions"

## plot to png

png("plot3.png") 
g <- qplot(year, Emissions, data=typePM25.year, color=type, geom ="line")+ 
        ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emmission by source, type and year")) + 
        xlab("Year")+ ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)"))
print(g)
dev.off()

