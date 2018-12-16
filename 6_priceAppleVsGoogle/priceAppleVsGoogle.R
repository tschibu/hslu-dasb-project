#Import Libraries
library(tidyverse)
library(plyr)
library(dplyr)
library(ggplot2)
library(utils)
library(gridExtra)
library(grid)

df <- read.csv("../resources/_dfAppleGoogle_merged.csv", header = TRUE, encoding = "UTF-8", stringsAsFactors = FALSE)
#View(df)

#Zwei Boxplots
papple <- ggplot(df, aes(x=category.x, y=price.x)) +
  geom_bar(position="dodge", colour="blue", stat = "identity")

pgoogle <- ggplot(df, aes(x=category.y, y=price.y)) +
  geom_bar(position="dodge", colour="red", stat = "identity")

grid.arrange(papple, pgoogle)
