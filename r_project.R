library(spotifyr)
library(tidyverse)

token = get_spotify_access_token()


test_df = get_featured_playlists()

test_playlist = get_playlist("37i9dQZF1DWXJfnUiYjUKT")
audio_features_test = get_playlist_audio_features(playlist_uris = c(test_playlist$id))

# need to fetch all playlists by ids

playlist_df = get_playlist_audio_features(playlist_uris = c(test_df$id))

# select columns that will be most useful
playlist_df = playlist_df %>% select(playlist_id, playlist_name, danceability, energy, key, loudness, mode, speechiness, acousticness, valence, tempo, track.id, track.artists, track.popularity, track.duration_ms, track.name, track.album.name)

# WRITE CSV to locally cache data
# write.csv(playlist_df, "./playlist_csv_2022058.csv", row.names = FALSE)

# read_csv to read the cached file
# playlist_df = read.csv("playlist_csv_20220506.csv")

playlist_df = playlist_df %>% unnest(track.artists)

# artist_df = get_artists(ids = c(playlist_df$id))

new_playlist_df = playlist_df %>% group_by(playlist_name)
table(playlist_df$track.name)
summary(playlist_df)
# sample random 50 from the playlist
playlist_sample = playlist_df %>% sample_n(50)
artists_df = get_artists(ids = c(playlist_sample$id))



artists_df %>% ggplot(aes(x = popularity, y = log(followers.total))) + geom_point() + labs(x="Popularity", y="Log of followers", title="Popularity vs. Log of Followers of 50 Artists")


?inner_join
playlist_sample = playlist_sample %>% inner_join(artists_df, by = c("name", "uri", "id", "type", "external_urls.spotify", "href" ))

playlist_df %>% ggplot(aes(track.popularity)) + geom_density() + theme(axis.ticks.y=element_blank(), axis.text.y = element_blank()) + labs(x="Popularity", y="Density", title="Density of Popularity")

playlist_sample %>% 
  ggplot(aes(x = energy, y = track.popularity)) + geom_point(aes(color=tempo)) + labs(x="Energy", y="Popularity", title="Popularity against Energy")


playlist_sample %>%
  ggplot(aes(x=log(followers.total), y=track.popularity)) + geom_point() + labs(x="Log of Followers", y="Track Popularity", title="Followers vs. Song popularity")

playlist_sample %>% 
  mutate(playlist_name = as.factor(playlist_name)) %>%
  group_by(playlist_id) %>%
  ggplot(aes(x = popularity, y = track.popularity)) + geom_point(aes(color=playlist_name)) +
  labs(x = "Artist Popularity", y = "Track Popularity", title="Artist Popularity vs. Track Popularity") + 
  scale_colour_discrete("Playlist Name")

?summarise
?n

playlist_df %>% mutate(artist_info = get_artist(id = playlist_df$id))
playlist_df = playlist_df %>% mutate(artist_info = lapply(id, get_artist))

data.frame(playlist_df$artist_info)
# every 9 rows it has artist popularity
# create condition that only gets certain rows
row_counter = 1:nrow(new_test_df)

pared_df = new_test_df[8:nrow(new_test_df), ]
pared_df = new_test_df[row_counter %% 10 == 0 +8, ]
pared_df$artist_info = pared_df$artist_info %>% as.numeric()
# selected correct items, need to convert artist_info to normal column DONE

?data.frame
