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

# 1. Creating Barplot to compare Rating between App Store & Play Store

## Create minimal DataFrame
dfMin <- data.frame(df$rating.x, df$rating.y, df$category.x)
head(dfMin)
dfMin <- rename(dfMin, c("df.rating.x"="App Store", "df.rating.y"="Play Store", "df.category.x"="Category"))

## Melt DataFrame to display both Prices in on Barplot
dfMelt <- melt(dfMin, id.vars='Category')
head(dfMelt)
dfMelt <- rename(dfMelt, c("variable"="Type", "value"="Rating"))

## Draw Barplot and rotate x Labels
ggplot(dfMelt, aes(x=Category, y=Rating, fill=Type)) +
  geom_bar(stat='identity', position='dodge') + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


# 2. Creating Linechart with average rating differences

dfDiff <- data.frame(df$category.x, df$rating.x - df$rating.y)
dfDiff <- rename(dfDiff, c("df.category.x"="Category", "df.rating.x...df.rating.y"="Difference"))
head(dfDiff)
ggplot(data=dfDiff, aes(x=Category, y=Difference)) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

