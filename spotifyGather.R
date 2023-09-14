# load libraries
library(Rspotify)
library(httr)
library(jsonlite)
library(spotifyr)
library(dplyr)

# authenticate
my_token <- get_spotify_access_token(client_id='71995685ca2446b2b6e2e41d3e0e5b7a', client_secret='c36f1c3a69a241d4a8d45240c42873b0')

# Edy playlist
E <- get_playlist_audio_features(
  username = 'spotify',
  playlist_uris = '3c9I1enzDFSTCEoI5y4Igv?si=f7171c2fd9eb43f1',
  authorization = my_token)

# select the columns we want
filteredE <- E %>% select(track.name, track.popularity, track.album.album_type, track.duration_ms, danceability, energy,
                          loudness, speechiness, acousticness, instrumentalness, liveness, valence, tempo)

# add playlist column
filteredE$Playlist <- 'Edy'

# export to csv
write.csv(filteredE, 'Desktop/SCHOOLS/GEORGETOWN/511 PROB/Final Project/edyPlaylist.csv')
