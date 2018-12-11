# Documentation
## Dataset
### Apple Store
[Apple Store](https://www.kaggle.com/ramamet4/app-store-apple-data-set-10k-apps/version/2)

### Google Play Store
[Google Play Store](https://www.kaggle.com/lava18/google-play-store-apps/version/4#googleplaystore_user_reviews.csv)

## Questions

1. Price (Steve)
    * Which category is the most expensive?
    * Same as 1. but withou Games
2. Rating between Android & Apple (David)
3. Number of supported languages (Remo)
4. Do Rating and Price correlate (Pascal)
5. Relation between rating and number of installs (Michael)
6. Pricing between Android and Apple (Steve)

## Merging of Datasets

### Column Mapping

| Apple Store      | Google Play Store     | Final Name  |  Description            |
|:-----------------|:----------------------|:------------|:------------------------|
| X                | -                     | Not used!   |  Id                     |
| id               | -                     | Not used!   |  AppStore Id            |
| track_name       | App                   | tbd         |  App Name               |
| size_bytes       | Size                  | tbd         |  App Size (bytes)       |
| currency         | -                     | Not used!   |  Currency (USD)         |
| -                | Type                  | Not used!   |  Price Type             |
| price            | Price                 | tbd         |  Price                  |
| rating_count_tot | Reviews               | tbd         |  Rating Count Total     |
| rating_count_ver | -                     | Not used!   |  Rating Count Version   |
| user_rating      | Rating                | tbd         |  User Rating            |
| user_rating_ver  | -                     | Not used!   |  User Rating Version    |
| ver              | Current.Ver           | tbd         |  Version                |
| cont_rating      | Content.Rating        | tbd         |  Min Age.               |
| prime_genre      | Category              | tbd         |  Genre                  |
| -                | Genres                | Not used!   |  Genre (List)           |
| sup_devices.num  | -                     | Not used!   |  Supported Devices      |
| ipdaSc_urls.num  | -                     | Not used!   |  Number of Screenshots  |
| lang.num         | -                     | Not used!   |  Languages              |
| vpp_lic          | -                     | Not used!   |  Volume License Program |
| -                | Installs              | Not used!   |  Number of Installs     |
| -                | Last.Updated          | Not used!   |  Last Update            |
| -                | Android.Ver           | Not used!   |  Last Update            |
