#Import Libraries
library(tidyverse)
library(plyr)
library(dplyr)
library(ggplot2)
library(utils)
library(corrgram)

#define plotting colors
c1 <- rainbow(6)
c2 <- rainbow(6, alpha=0.2)
c3 <- rainbow(6, v=0.7)
c4 <- rainbow(6, alpha=0.5)

#set margins for plots
par(mar=c(8,3,1,1))

#Import Data
#Mui Importanti: UTF8 Encoding muss ausgewählt werden, sonst sieht alles merkwürdig aus
dfPlayStore <- read.csv("../../resources/googleplaystore.csv", header = TRUE, stringsAsFactors = FALSE)
head(dfPlayStore)

#look at all values in "installs" column
unique(dfPlayStore$Installs)

#drop all rows with "free" number of installs
df<-subset(dfPlayStore, Installs!="Free")

#check if gone
unique(df$Installs)

#count how often each value is repeated
installNumberTable = table(df$Installs)

#plot the findings
barplot(installNumberTable, las=2, col=rainbow(20, alpha=0.5), border = NA)

#change install values
df$InstallsNumeric[df$Installs=="0"] <- 0
df$InstallsNumeric[df$Installs=="0+"] <- 0
df$InstallsNumeric[df$Installs=="1+"] <- 1
df$InstallsNumeric[df$Installs=="5+"] <- 5
df$InstallsNumeric[df$Installs=="10+"] <- 10
df$InstallsNumeric[df$Installs=="50+"] <- 50
df$InstallsNumeric[df$Installs=="100+"] <- 100
df$InstallsNumeric[df$Installs=="500+"] <- 500
df$InstallsNumeric[df$Installs=="1,000+"] <- 1000
df$InstallsNumeric[df$Installs=="5,000+"] <- 5000
df$InstallsNumeric[df$Installs=="10,000+"] <- 10000
df$InstallsNumeric[df$Installs=="50,000+"] <- 50000
df$InstallsNumeric[df$Installs=="100,000+"] <- 100000
df$InstallsNumeric[df$Installs=="500,000+"] <- 500000
df$InstallsNumeric[df$Installs=="1,000,000+"] <- 1000000
df$InstallsNumeric[df$Installs=="5,000,000+"] <- 5000000
df$InstallsNumeric[df$Installs=="10,000,000+"] <- 10000000
df$InstallsNumeric[df$Installs=="50,000,000+"] <- 50000000
df$InstallsNumeric[df$Installs=="100,000,000+"] <- 100000000
df$InstallsNumeric[df$Installs=="500,000,000+"] <- 500000000
df$InstallsNumeric[df$Installs=="1,000,000,000+"] <- 1000000000
df$InstallsNumeric = as.numeric(df$InstallsNumeric)

#check if it worked
unique(df$InstallsNumeric)

#Replace al NaN-Values with the Mean-Rating
df$Rating[is.nan(df$Rating)] = mean(df$Rating, na.rm=TRUE)
mean(df$Rating)

#check for correlatoin
cor(df$Rating, df$InstallsNumeric)

#count how often each value is repeated
installNumberNumericTable = table(df$InstallsNumeric)

#plot the findings
barplot(installNumberNumericTable, las=2, col=rainbow(20, alpha=0.5), border = NA)

#group installs
df$InstallsGrouped[df$Installs=="0"] <- "1: unter 1000"
df$InstallsGrouped[df$Installs=="0+"] <- "1: unter 1000"
df$InstallsGrouped[df$Installs=="1+"] <- "1: unter 1000"
df$InstallsGrouped[df$Installs=="5+"] <- "1: unter 1000"
df$InstallsGrouped[df$Installs=="10+"] <- "1: unter 1000"
df$InstallsGrouped[df$Installs=="50+"] <- "1: unter 1000"
df$InstallsGrouped[df$Installs=="100+"] <- "1: unter 1000"
df$InstallsGrouped[df$Installs=="500+"] <- "1: unter 1000"
df$InstallsGrouped[df$Installs=="1,000+"] <- "2: 1000 - 10k"
df$InstallsGrouped[df$Installs=="5,000+"] <- "2: 1000 - 10k"
df$InstallsGrouped[df$Installs=="10,000+"] <- "3: 10k - 100k"
df$InstallsGrouped[df$Installs=="50,000+"] <- "3: 10k - 100k"
df$InstallsGrouped[df$Installs=="100,000+"] <- "4: 100k - 1 Mio"
df$InstallsGrouped[df$Installs=="500,000+"] <- "4: 100k - 1 Mio"
df$InstallsGrouped[df$Installs=="1,000,000+"] <- "5: 1 Mio - 10 Mio"
df$InstallsGrouped[df$Installs=="5,000,000+"] <- "5: 1 Mio - 10 Mio"
df$InstallsGrouped[df$Installs=="10,000,000+"] <- "6: über 10 Mio"
df$InstallsGrouped[df$Installs=="50,000,000+"] <- "6: über 10 Mio"
df$InstallsGrouped[df$Installs=="100,000,000+"] <- "6: über 10 Mio"
df$InstallsGrouped[df$Installs=="500,000,000+"] <- "6: über 10 Mio"
df$InstallsGrouped[df$Installs=="1,000,000,000+"] <- "6: über 10 Mio"

#check if it worked
unique(df$InstallsGrouped)

#count how often each value is repeated
installNumberGroupedTable = table(df$InstallsGrouped)

#plot the findings
barplot(installNumberGroupedTable, las=2, col=c4, border = NA)

#boxplot diagram
boxplot(df$Rating ~ df$InstallsGrouped, las=2, col=c2, medcol=c3, whiskcol=c1, staplecol=c3, boxcol=c3, outcol=c3, pch=1, cex=0.8)

