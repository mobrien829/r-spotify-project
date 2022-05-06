library(spotifyr)
library(tidyverse)

token = get_spotify_access_token()


test_df = get_featured_playlists()

test_playlist = get_playlist("37i9dQZF1DWXJfnUiYjUKT")
audio_features_test = get_playlist_audio_features(playlist_uris = c(test_playlist$id))

# need to fetch all playlists by ids

playlist_df = get_playlist_audio_features(playlist_uris = c(test_df$id))

# select columns that will be most useful
playlist_df = playlist_df %>% select(playlist_id, danceability, energy, key, loudness, mode, speechiness, acousticness, valence, tempo, track.id, track.duration_ms, track.name, track.album.name)

# WRITE CSV to locally cache data
# write.csv(playlist_df, "./playlist_csv_20220506.csv", row.names = FALSE)
