## This is the code I used to retrieve the tweets.

## I started to ask the API for 5000 tweets but realized it wasn't
## enough to get them all, so I did a second call, that reached the
## limit on how far back it can get.

## To archive the data, I generated a RDS file, that I later exported
## to CSV and archived on figshare.

library(twitteR)

# Load saved tweets
twitter_data <- "data/data_frame_all_tweets.rds"
dt_tweets <- readRDS(twitter_data)

# Search tweets with larger IDs than what we already have
new_tweets <- searchTwitter("#ICCB2015", n = 5000, sinceID = max(dt_tweets$id))

time_updated <- Sys.time()
time_stamp <- format(time_updated, "%Y-%m-%d_%H-%M")

if (length(new_tweets) > 1) {
  # Make request and use now as a timestamp
  
  saveRDS(new_tweets, file.path("data", paste0("raw_tweets_", time_stamp, 
                                               ".rds")))
  
  dt_new_tweets <- twListToDF(new_tweets)
  
  all_tweets <- rbind(dt_tweets, dt_new_tweets)
  saveRDS(all_tweets, file = twitter_data)
}
