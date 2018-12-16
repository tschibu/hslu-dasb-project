#1. Price (Steve)
#* Which category is the most expensive?
#  * Same as 1. but without Games

#Import Libraries
library(tidyverse)
library(plyr)
library(dplyr)
library(ggplot2)
library(mgcv)
library(utils)

dfAppleStore <- read.csv("../resources/AppleStore.csv", header = TRUE, encoding = "UTF-8", stringsAsFactors = FALSE)
dfPlayStore <- read.csv("../resources/googleplaystore.csv", header = TRUE,encoding = "UTF-8", stringsAsFactors = FALSE)
dfAppleGoogle <- read.csv("../resources/_dfAppleGoogle_merged.csv", header = TRUE,encoding = "UTF-8", stringsAsFactors = FALSE)


##Apple

ggplot(data = dfAppleStore, mapping = aes(x = prime_genre, y = price)) +
  geom_point(mapping = aes(color = user_rating)) +
  coord_flip()

#ist etwas unübersichtlich, also machen wir etwas anderes

#Median und Mittelwert aller Kategorien berechnen, in eine neue Spalte und danach darstellen


ddply(dfAppleStore, .(Cate), summarize,  Rate1=mean(Rate1), Rate2=mean(Rate2))

##########
##Google##
##########

ggplot(data = dfPlayStore, mapping = aes(x = Installs, y = Price)) +
  geom_point(mapping = aes(color = Category)) +
  coord_flip()

ggplot(data = dfPlayStore, mapping = aes(x = Category, y = Price)) + 
  geom_point(mapping = aes(color = Category)) +
  coord_flip()


#Median und Mittelwert aller Kategorien berechnen, in eine neue Spalte und danach darstellen


#price playstore: remove dollar from Playstore Price (y)
dfPlayStore$Price = as.numeric(gsub("\\$", "", dfPlayStore$Price))

dfPlay_price_cat <- ddply(dfPlayStore, .(Category), summarize,  PriceMean=mean(Price))

ggplot(data = dfPlay_price_cat, mapping = aes(x = Category, y = PriceMean)) + 
  geom_point(mapping = aes(color = Category)) +
  coord_flip()

#Jetzt dasselbe ohne Gratis (0) apps

dfPlay_price_cat_withoutZero <- filter(dfPlayStore, Price > 0)
dfPlay_price_cat_withoutZero <- ddply(dfPlay_price_cat_withoutZero, .(Category), summarize,  PriceMean=mean(Price), PriceMedian=median(Price))
 
ggplot(data = dfPlay_price_cat_withoutZero, mapping = aes(x = Category, y = PriceMean)) + 
  geom_point(mapping = aes(color = Category)) +
  coord_flip()

#nur mit ausreissern: Mean
dfPlay_price_cat_withoutZero_onlyAusreisser <- filter(dfPlayStore, (Category %in% c("LIFESTYLE" , "FINANCE" , "EVENTS", "FAMILY", "MEDICAL")))
dfPlay_price_cat_withoutZero_onlyAusreisser <- ddply(dfPlay_price_cat_withoutZero_onlyAusreisser, .(Category), summarize,  PriceMean=mean(Price), PriceMedian=median(Price))

ggplot(data = dfPlay_price_cat_withoutZero_onlyAusreisser, mapping = aes(x = Category, y = PriceMean)) + 
  geom_point(mapping = aes(color = Category), size=3,  shape=PriceMedian) +
  coord_flip()


#ohne ausreisser: LifeStyle, Finance, Events
dfPlay_price_cat_withoutZero_andAusreisser <- filter(dfPlayStore, !(Category %in% c("LIFESTYLE" , "FINANCE" , "EVENTS", "FAMILY", "MEDICAL")))
dfPlay_price_cat_withoutZero_andAusreisser <- ddply(dfPlay_price_cat_withoutZero_andAusreisser, .(Category), summarize,  PriceMean=mean(Price), PriceMedian=median(Price))


ggplot(data = dfPlay_price_cat_withoutZero_andAusreisser, mapping = aes(x = Category, y = PriceMean)) + 
  geom_point(mapping = aes(color = Category), size=3) +
  coord_flip()





#Median
ggplot(data = dfPlay_price_cat_withoutZero, mapping = aes(x = Category, y = PriceMedian)) + 
  geom_point(mapping = aes(color = Category)) +
  coord_flip()


