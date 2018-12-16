#Import Libraries
library(tidyverse)
library(plyr)
library(dplyr)
library(ggplot2)
library(utils)

#Import Data
#Mui Importanti: UTF8 Encoding muss ausgewählt werden, sonst sieht alles merkwürdig aus
dfAppleStore <- read.csv("../resources/AppleStore.csv", header = TRUE, fileEncoding = "UTF-8", stringsAsFactors = FALSE)
dfPlayStore <- read.csv("../resources/googleplaystore.csv", header = TRUE,fileEncoding = "UTF-8", stringsAsFactors = FALSE)

head(dfAppleStore)
head(dfPlayStore)

#Remove values from Apple Dataframe
dfAppleStore$X <- NULL
dfAppleStore$id <- NULL
dfAppleStore$currency <- NULL
dfAppleStore$rating_count_ver <- NULL
dfAppleStore$user_rating_ver <- NULL
dfAppleStore$sup_devices.num <- NULL
dfAppleStore$ipadSc_urls.num <- NULL
dfAppleStore$lang.num <- NULL
dfAppleStore$vpp_lic <- NULL

#Remove values from Google Dataframe
dfPlayStore$Type <- NULL
dfPlayStore$Genres <- NULL
dfPlayStore$Installs <- NULL
dfPlayStore$Last.Updated <- NULL
dfPlayStore$Android.Ver <- NULL

#Rename Columns Apple
colnames(dfAppleStore)[which(names(dfAppleStore) == "track_name")] <- "app_name"
colnames(dfAppleStore)[which(names(dfAppleStore) == "prime_genre")] <- "category"
colnames(dfAppleStore)[which(names(dfAppleStore) == "user_rating")] <- "rating"
colnames(dfAppleStore)[which(names(dfAppleStore) == "rating_count_tot")] <- "rating_count"
colnames(dfAppleStore)[which(names(dfAppleStore) == "ver")] <- "version"
colnames(dfAppleStore)[which(names(dfAppleStore) == "cont_rating")] <- "player_age"

#Rename Columns Google
colnames(dfPlayStore)[which(names(dfPlayStore) == "App")] <- "app_name"
colnames(dfPlayStore)[which(names(dfPlayStore) == "Category")] <- "category"
colnames(dfPlayStore)[which(names(dfPlayStore) == "Rating")] <- "rating"
colnames(dfPlayStore)[which(names(dfPlayStore) == "Reviews")] <- "rating_count"
colnames(dfPlayStore)[which(names(dfPlayStore) == "Size")] <- "size_bytes"
colnames(dfPlayStore)[which(names(dfPlayStore) == "Price")] <- "price"
colnames(dfPlayStore)[which(names(dfPlayStore) == "Content.Rating")] <- "player_age"
colnames(dfPlayStore)[which(names(dfPlayStore) == "Current.Ver")] <- "version"

#Reorder Columns
dfAppleStore <- dfAppleStore[c("app_name", "category", "price", "rating", "rating_count", "size_bytes", "player_age", "version")]
dfPlayStore <- dfPlayStore[c("app_name", "category", "price", "rating", "rating_count", "size_bytes", "player_age", "version")]

head(dfAppleStore)
head(dfPlayStore)

#Get unique categories
apple_categories <- list(unique(dfAppleStore$category))
apple_categories

google_categories <- list(unique(dfPlayStore$category))
google_categories

#Rename Category Values in Apple Dataframe
dfAppleStore$category[dfAppleStore$category=="Health & Fitness"] <- "Health and Fitness"
dfAppleStore$category[dfAppleStore$category=="Photo & Video"] <- "Photo and Video"
dfAppleStore$category[dfAppleStore$category=="Food & Drink"] <- "Food and Drink"
dfAppleStore$category[dfAppleStore$category=="Catalogs"] <- "Utilities"
dfAppleStore$category[dfAppleStore$category=="Music"] <- "Lifestyle"
dfAppleStore$category[dfAppleStore$category=="Reference"] <- "Utilities"

#Rename Category Values in Google Play Dataframe
dfPlayStore$category[dfPlayStore$category=="GAME"] <- "Games"
dfPlayStore$category[dfPlayStore$category=="PRODUCTIVITY"] <- "Productivity"
dfPlayStore$category[dfPlayStore$category=="WEATHER"] <- "Weather"
dfPlayStore$category[dfPlayStore$category=="SHOPPING"] <- "Shopping"
dfPlayStore$category[dfPlayStore$category=="FINANCE"] <- "Finance"
dfPlayStore$category[dfPlayStore$category=="TOOLS"] <- "Utilities"
dfPlayStore$category[dfPlayStore$category=="TRAVEL_AND_LOCAL"] <- "Travel"
dfPlayStore$category[dfPlayStore$category=="DATING"] <- "Social Networking"
dfPlayStore$category[dfPlayStore$category=="SOCIAL"] <- "Social Networking"
dfPlayStore$category[dfPlayStore$category=="SPORTS"] <- "Sports"
dfPlayStore$category[dfPlayStore$category=="BUSINESS"] <- "Business"
dfPlayStore$category[dfPlayStore$category=="BEAUTY"] <- "Health and Fitness"
dfPlayStore$category[dfPlayStore$category=="HEALTH_AND_FITNESS"] <- "Health and Fitness"
dfPlayStore$category[dfPlayStore$category=="COMICS"] <- "Entertainment"
dfPlayStore$category[dfPlayStore$category=="ENTERTAINMENT"] <- "Entertainment"
dfPlayStore$category[dfPlayStore$category=="PHOTOGRAPHY"] <- "Photo and Video"
dfPlayStore$category[dfPlayStore$category=="VIDEO_PLAYERS"] <- "Photo and Video"
dfPlayStore$category[dfPlayStore$category=="MAPS_AND_NAVIGATION"] <- "Navigation"
dfPlayStore$category[dfPlayStore$category=="EDUCATION"] <- "Education"
dfPlayStore$category[dfPlayStore$category=="FAMILY"] <- "Education"
dfPlayStore$category[dfPlayStore$category=="ART_AND_DESIGN"] <- "Lifestyle"
dfPlayStore$category[dfPlayStore$category=="LIFESTYLE"] <- "Lifestyle"
dfPlayStore$category[dfPlayStore$category=="HOUSE_AND_HOME"] <- "Lifestyle"
dfPlayStore$category[dfPlayStore$category=="AUTO_AND_VEHICLES"] <- "Lifestyle"
dfPlayStore$category[dfPlayStore$category=="FOOD_AND_DRINK"] <- "Food and Drink"
dfPlayStore$category[dfPlayStore$category=="PARENTING"] <- "Lifestyle"
dfPlayStore$category[dfPlayStore$category=="EVENTS"] <- "Lifestyle"
dfPlayStore$category[dfPlayStore$category=="NEWS_AND_MAGAZINES"] <- "News"
dfPlayStore$category[dfPlayStore$category=="BOOKS_AND_REFERENCE"] <- "Book"
dfPlayStore$category[dfPlayStore$category=="MEDICAL"] <- "Medical"
dfPlayStore$category[dfPlayStore$category=="COMMUNICATION"] <- "Utilities"
dfPlayStore$category[dfPlayStore$category=="LIBRARIES_AND_DEMO"] <- "Utilities"
dfPlayStore$category[dfPlayStore$category=="PERSONALIZATION"] <- "Utilities"
dfPlayStore$category[dfPlayStore$category=="1.9"] <- "Utilities"

#Match Player Age in Google Play Dataframe
dfPlayStore$player_age[dfPlayStore$player_age=="Everyone"] <- "4+"
dfPlayStore$player_age[dfPlayStore$player_age=="Teen"] <- "12+"
dfPlayStore$player_age[dfPlayStore$player_age=="Everyone 10+"] <- "9+"
dfPlayStore$player_age[dfPlayStore$player_age=="Mature 17+"] <- "17+"
dfPlayStore$player_age[dfPlayStore$player_age=="Adults only 18+"] <- "17+"
dfPlayStore$player_age[dfPlayStore$player_age=="Unrated"] <- "4+"
dfPlayStore$player_age[dfPlayStore$player_age==""] <- "4+"

#add source data colum for apple data frame
dfAppleStore$source <- "apple"
dfPlayStore$source <- "google"

head(dfAppleStore)
head(dfPlayStore)

#Merge the two data frame

dfAppleGoogle <-merge(dfAppleStore, dfPlayStore, all=TRUE, sort=TRUE)
dfAppleGoogleSorted <- arrange(dfAppleGoogle, app_name)
View(dfAppleGoogleSorted)



