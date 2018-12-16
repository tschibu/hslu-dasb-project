#Import Libraries
library(tidyverse)
library(plyr)
library(dplyr)
library(ggplot2)
library(utils)

#Import Data
dfAppleStore <- read.csv("../resources/AppleStore.csv", header = TRUE)
dfPlayStore <- read.csv("../resources/googleplaystore.csv", header = TRUE)

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

#add source data colum for apple data frame
dfAppleStore$source <- "apple"
dfPlayStore$source <- "google"

head(dfAppleStore)
head(dfPlayStore)

#Merge the two data frame


dfAppleGoogle <-merge(dfAppleStore, dfPlayStore, all=TRUE, sort=TRUE)

View(dfAppleGoogle)

#matching categories
#not working
#dfPlayStore$category[which(dfPlayStore$category =="PRODUCTIVITY")]<-"Productivity"
#dfPlayStore$category[which(dfPlayStore$category =="WEATHER")]<-"Weather"
#dfPlayStore$category[which(dfPlayStore$category =="SHOPPING")]<-"Shopping"
#dfPlayStore$category[which(dfPlayStore$category =="FINANCE")]<-"Finance"
#dfPlayStore$category[which(dfPlayStore$category =="TOOLS")]<-"Utilities"
#dfPlayStore$category[which(dfPlayStore$category =="TRAVEL_AND_LOCAL")]<-"Travel"
#dfPlayStore$category[which(dfPlayStore$category =="DATING")]<-"Social"
#dfPlayStore$category[which(dfPlayStore$category =="SOCIAL")]<-"Social"
#dfPlayStore$category[which(dfPlayStore$category =="SPORTS")]<-"Sports"
#dfPlayStore$category[which(dfPlayStore$category =="BUSINESS")]<-"Business"

#dfAppleStore$category[which(dfAppleStore$category =="Health & Fitness")]<-"Health and Fitness"
#dfPlayStore$category[which(dfPlayStore$category =="BEAUTY")]<-"Health and Fitness"
#dfPlayStore$category[which(dfPlayStore$category =="HEALTH_AND_FITNESS")]<-"Health and Fitness"

#dfPlayStore$category[which(dfPlayStore$category =="COMICS")]<-"Entertainment"

