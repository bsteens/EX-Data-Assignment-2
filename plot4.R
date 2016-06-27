setwd("~/Desktop/Coursera/EX Data 2/EX Data Assignment 2")

library(ggplot2)
library(plyr)

## read data

PMdata <- readRDS("summarySCC_PM25.rds")
PMcodes <- readRDS("Source_Classification_Code.rds")

## subset the data for coal combustion

coalcomb.scc <- subset(PMcodes, EI.Sector %in% c("Fuel Comb - Comm/Instutional - Coal", 
                                             "Fuel Comb - Electric Generation - Coal", "Fuel Comb - Industrial Boilers, ICEs - 
                                             Coal"))

coalcomb.scc1 <- subset(PMcodes, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))

nrow(coalcomb.scc) 

nrow(coalcomb.scc1)

## set the differences

dif1 <- setdiff(coalcomb.scc$SCC, coalcomb.scc1$SCC)
dif2 <- setdiff(coalcomb.scc1$SCC, coalcomb.scc$SCC)

length(dif1)

length(dif2)

coalcomb.codes <- union(coalcomb.scc$SCC, coalcomb.scc1$SCC)
length(coalcomb.codes)

## subset 

coal.comb <- subset(PMdata, SCC %in% coalcomb.codes)

## getting PM25 values

coalcomb.pm25year <- ddply(coal.comb, .(year, type), function(x) sum(x$Emissions))
colnames(coalcomb.pm25year)[3] <- "Emissions"

## plot the png
png("plot4.png")
p <- qplot(year, Emissions, data=coalcomb.pm25year, color=type, geom="line") + 
        stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "purple", aes(shape="total"), geom="line") + 
        geom_line(aes(size="total", shape = NA)) + ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + 
        xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
print(p)
dev.off()
