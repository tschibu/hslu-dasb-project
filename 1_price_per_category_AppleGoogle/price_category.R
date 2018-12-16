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




#------------------------------------------------

##########
##Google##
##########


###
#Median und Mittelwert aller Kategorien berechnen, in eine neue Spalte und danach darstellen
###

## Basic Overview Without Free Apps

#price playstore: remove dollar from Playstore Price (y)
dfPlayStore$Price = as.numeric(gsub("\\$", "", dfPlayStore$Price))

dfPlay_price_cat <- ddply(dfPlayStore, .(Category), summarize,  PriceMean=mean(Price))

ggplot(data = dfPlay_price_cat, mapping = aes(x = Category, y = PriceMean)) + 
  geom_point(mapping = aes(color = Category), size = 3 ) +
  ggtitle("Google: Price per Category, with Free Apps") +
  xlab("Category") + ylab("Price Mean ($)") + labs(colour = "Categories") +
  coord_flip()

# Basic Overview Without Free Apps

dfPlay_price_cat_wo_0 <- filter(dfPlayStore, Price > 0.1)
dfPlay_price_cat_wo_0 <- ddply(dfPlay_price_cat_wo_0, .(Category), summarize,  PriceMean=mean(Price), PriceMedian=median(Price))

ggplot(data = dfPlay_price_cat_wo_0, mapping = aes(x = Category, y = PriceMean)) + 
  geom_point(mapping = aes(color = Category), size = 3 ) +
  ggtitle("Google: Price per Category, without Free Apps") +
  xlab("Category") + ylab("Price Mean ($)") + labs(colour = "Categories") +
  coord_flip()

#TOP7: nur mit ausreissern: Mean
dfPlay_price_cat_TOP7 <- filter(dfPlayStore, (Category %in% c("LIFESTYLE" , "FINANCE" , "EVENTS", "FAMILY", "MEDICAL", "PRODUCTIVITY", "BOOKS_AND_REFERENCE")))
dfPlay_price_cat_TOP7 <- ddply(dfPlay_price_cat_TOP7, .(Category), summarize,  PriceMean=mean(Price), PriceMedian=median(Price))

ggplot(data = dfPlay_price_cat_TOP7, mapping = aes(x = Category, y = PriceMean)) + 
  geom_point(mapping = aes(color = Category), size=dfPlay_price_cat_TOP7$PriceMean+2) +
  ggtitle("Google: Price per Category, Top 7") +
  xlab("Category") + ylab("Price Mean ($)") + labs(colour = "Categories") +
  coord_flip()


#Without TOP7: ohne ausreisser: LifeStyle, Finance, Events
dfPlay_price_cat_wo_TOP7 <- filter(dfPlayStore, !(Category %in% c("LIFESTYLE" , "FINANCE" , "EVENTS", "FAMILY", "MEDICAL" ,"PRODUCTIVITY" ,"BOOKS_AND_REFERENCE")))
dfPlay_price_cat_wo_TOP7 <- ddply(dfPlay_price_cat_wo_TOP7, .(Category), summarize,  PriceMean=mean(Price), PriceMedian=median(Price))
#remove NA value
dfPlay_price_cat_wo_TOP7 <- dfPlay_price_cat_wo_TOP7[-c(1),]


ggplot(data = dfPlay_price_cat_wo_TOP7, mapping = aes(x = Category, y = PriceMean)) + 
  geom_point(mapping = aes(color = Category), size=dfPlay_price_cat_wo_TOP7$PriceMean*5 +3 ) +
  ggtitle("Google: Price per Category, without Top 7") +
  xlab("Category") + ylab("Price Mean ($)") + labs(colour = "Categories") +
  coord_flip()


#---------------------------------------------------------

#########
# Apple #
#########


###
#Median und Mittelwert aller Kategorien berechnen, in eine neue Spalte und danach darstellen
###

#Basic Overview (Mit Gratis Apps)

dfApple_price_cat <- ddply(dfAppleStore, .(prime_genre), summarize,  PriceMean=mean(price))

ggplot(data = dfApple_price_cat, mapping = aes(x = prime_genre, y = PriceMean)) + 
  geom_point(mapping = aes(color = prime_genre), size = 4 ) +
  ggtitle("Apple: Price per Category. Without free Apps") +
  xlab("Category") + ylab("Price Mean ($)") + labs(colour = "Categories") +
  coord_flip()

#Basic Overview (without free Apps)

dfPlay_price_cat_wo_0 <- filter(dfAppleStore, price > 0.1)
dfPlay_price_cat_wo_0 <- ddply(dfPlay_price_cat_wo_0, .(prime_genre), summarize,  PriceMean=mean(price), PriceMedian=median(price))

ggplot(data = dfPlay_price_cat_wo_0, mapping = aes(x = prime_genre, y = PriceMean)) + 
  geom_point(mapping = aes(color = prime_genre), size = 4 ) +
  ggtitle("Apple: Price per Category. Without free Apps") +
  xlab("Category") + ylab("Price Mean ($)") + labs(colour = "Categories") +
  coord_flip()

#TOP7: nur mit ausreissern: Mean
dfApple_price_cat_TOP7 <- filter(dfAppleStore, (prime_genre %in% c("Medical" , "Music" , "Reference", "Productivity", "Catalogs", "Business", "Navigation")))
dfApple_price_cat_TOP7 <- ddply(dfApple_price_cat_TOP7, .(prime_genre), summarize,  PriceMean=mean(price), PriceMedian=median(price))

ggplot(data = dfApple_price_cat_TOP7, mapping = aes(x = prime_genre, y = PriceMean)) + 
  geom_point(mapping = aes(color = prime_genre), size=dfApple_price_cat_TOP7$PriceMean+1) +
  ggtitle("Apple: Price per Category, Top 7") +
  xlab("Category") + ylab("Price Mean ($)") + labs(colour = "Categories") +
  coord_flip()


#Without TOP7: ohne ausreisser: LifeStyle, Finance, Events
dfApple_price_cat_wo_TOP7 <- filter(dfAppleStore, !(prime_genre %in% c("Medical" , "Music" , "Reference", "Productivity", "Catalogs", "Business", "Navigation")))
dfApple_price_cat_wo_TOP7 <- ddply(dfApple_price_cat_wo_TOP7, .(prime_genre), summarize,  PriceMean=mean(price), PriceMedian=median(price))


ggplot(data = dfApple_price_cat_wo_TOP7, mapping = aes(x = prime_genre, y = PriceMean)) + 
  geom_point(mapping = aes(color = prime_genre), size=dfApple_price_cat_wo_TOP7$PriceMean + 3) +
  ggtitle("Apple: Price per Category, without Top 7") +
  xlab("Category") + ylab("Price Mean ($)") + labs(colour = "Categories") +
  coord_flip()

#--------------------------------------------------------
##
#Facets with Apple vs Google
##

#Without Top 7

# -- adjust all categories
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="GAME"] <- "Games"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="PRODUCTIVITY"] <- "Productivity"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="WEATHER"] <- "Weather"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="SHOPPING"] <- "Shopping"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="FINANCE"] <- "Finance"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="TOOLS"] <- "Utilities"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="TRAVEL_AND_LOCAL"] <- "Travel"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="DATING"] <- "Social Networking"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="SOCIAL"] <- "Social Networking"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="SPORTS"] <- "Sports"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="BUSINESS"] <- "Business"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="BEAUTY"] <- "Health & Fitness"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="HEALTH_AND_FITNESS"] <- "Health & Fitness"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="COMICS"] <- "Entertainment"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="ENTERTAINMENT"] <- "Entertainment"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="PHOTOGRAPHY"] <- "Photo & Video"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="VIDEO_PLAYERS"] <- "Photo & Video"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="MAPS_AND_NAVIGATION"] <- "Navigation"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="EDUCATION"] <- "Education"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="FAMILY"] <- "Education"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="ART_AND_DESIGN"] <- "Lifestyle"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="LIFESTYLE"] <- "Lifestyle"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="HOUSE_AND_HOME"] <- "Lifestyle"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="AUTO_AND_VEHICLES"] <- "Lifestyle"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="FOOD_AND_DRINK"] <- "Food & Drink"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="PARENTING"] <- "Lifestyle"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="EVENTS"] <- "Lifestyle"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="NEWS_AND_MAGAZINES"] <- "News"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="BOOKS_AND_REFERENCE"] <- "Book"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="MEDICAL"] <- "Medical"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="COMMUNICATION"] <- "Utilities"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="LIBRARIES_AND_DEMO"] <- "Utilities"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="PERSONALIZATION"] <- "Utilities"
dfPlay_price_cat_wo_TOP7$Category[dfPlay_price_cat_wo_TOP7$Category=="1.9"] <- "Utilities"

ggplot() + 
  geom_point(data = dfApple_price_cat_wo_TOP7,aes(x = dfApple_price_cat_wo_TOP7$prime_genre, y = dfApple_price_cat_wo_TOP7$PriceMean), color = 'red', size=dfApple_price_cat_wo_TOP7$PriceMean + 3) +
  geom_point(data = dfPlay_price_cat_wo_TOP7, aes(x = dfPlay_price_cat_wo_TOP7$Category, y = dfPlay_price_cat_wo_TOP7$PriceMean), color = 'green', size=dfPlay_price_cat_wo_TOP7$PriceMean*5 +2 ) +
  ggtitle("Apple(red) vs Google(green)\nPrice per Category, without Top 7 Categories") +
  xlab("Category") + ylab("Price Mean ($)") + labs(colour = "Categories") +
  coord_flip()


#Only Top 7

#--adjust the same named categories
dfPlay_price_cat_TOP7$Category[dfPlay_price_cat_TOP7$Category=="PRODUCTIVITY"] <- "Productivity"
dfPlay_price_cat_TOP7$Category[dfPlay_price_cat_TOP7$Category=="MEDICAL"] <- "Medical"
dfPlay_price_cat_TOP7$Category[dfPlay_price_cat_TOP7$Category=="BOOKS_AND_REFERENCE"] <- "Reference"

ggplot() + 
  geom_point(data = dfApple_price_cat_TOP7,aes(x = dfApple_price_cat_TOP7$prime_genre, y = dfApple_price_cat_TOP7$PriceMean), color = 'red', size=dfApple_price_cat_TOP7$PriceMean + 1) +
  geom_point(data = dfPlay_price_cat_TOP7, aes(x = dfPlay_price_cat_TOP7$Category, y = dfPlay_price_cat_TOP7$PriceMean), color = 'green', size=dfPlay_price_cat_TOP7$PriceMean + 2 ) +
  ggtitle("Apple(red) vs Google(green)\nPrice per Category, Top 7 Categories") +
  xlab("Category") + ylab("Price Mean ($)") + labs(colour = "Categories") +
  coord_flip()



#--------------------------------------------------------

####
##Pie Charts -> code was lost thanks to Github Overwrite
####


