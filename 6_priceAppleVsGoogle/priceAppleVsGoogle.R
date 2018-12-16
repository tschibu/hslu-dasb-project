#Import Libraries
library(tidyverse)
library(plyr)
library(dplyr)
library(ggplot2)
library(utils)
library(gridExtra)
library(grid)
library(reshape2)

df <- read.csv("../resources/_dfAppleGoogle_merged.csv", header = TRUE, encoding = "UTF-8", stringsAsFactors = FALSE)
#View(df) #Uncomment to view Data

# 1. Creating Barplot to compare Prices between App Store & Play Store

## Create minimal DataFrame
dfMin <- data.frame(df$price.x, df$price.y, df$category.x)
head(dfMin)
dfMin <- rename(dfMin, c("df.price.x"="App Store", "df.price.y"="Play Store", "df.category.x"="Category"))

## Melt DataFrame to display both Prices in on Barplot
dfMelt <- melt(dfMin, id.vars='Category')
head(dfMelt)
dfMelt <- rename(dfMelt, c("variable"="Type", "value"="Price"))

## Draw Barplot and rotate x Labels
ggplot(dfMelt, aes(x=Category, y=Price, fill=Type)) +
  geom_bar(stat='identity', position='dodge') + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


