library(spotifyr)
library(tidyverse)

token = get_spotify_access_token()


test_df = get_featured_playlists()

test_playlist = get_playlist("37i9dQZF1DWXJfnUiYjUKT")
audio_features_test = get_playlist_audio_features(playlist_uris = c(test_playlist$id))
