#Import Libraries
library(tidyverse)
library(plyr)
library(dplyr)
library(ggplot2)
library(utils)

# Remove all dataset's
rm(list = ls())

#Import Data
#Mui Importanti: UTF8 Encoding muss ausgewählt werden, sonst sieht alles merkwürdig aus
dfAppleStore <- read.csv("../resources/AppleStore.csv", header = TRUE, encoding = "UTF-8", stringsAsFactors = FALSE)
head(dfAppleStore)

# dinebsuibs of the object
dim(dfAppleStore)
str(dfAppleStore) # the structure of the dataset

# A plot line showing the relation between number of languages supported 
# by an app and it's quality/user rating.
ggplot(aes(x=user_rating,y=lang.num), data =dfAppleStore) +
  geom_line(stat = 'summary', fun.y = mean, colour="#FF0000") +
  labs (x="Average user_rating", y="# language supported",
        title="The relation between # languages supported 
        by an app and it's user rating")+
  theme(text = element_text(size=20),
        axis.text.x = element_text(angle=90, hjust=1))

# Summary of the lang.num
summary(dfAppleStore$lang.num)

# max of supports => supports 75 languages
dfAppleStore %>%
  filter(dfAppleStore$lang.num == 75)

