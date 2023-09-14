# Spotify Data Retrieval to compare
# musical trends across decades
# Get packages
library(Rspotify)
library(httr)
library(jsonlite)
library(spotifyr) 
library(tidyverse)

# Authenticate
my_token <- get_spotify_access_token()

# Get a list of songs for each decade

# 1950s
music50s <- get_playlist_audio_features("spotify", 
                                        playlist_uris = "37i9dQZF1DWSV3Tk4GO2fq",
                                        authorization = my_token) %>%
  mutate(tag = "1950s")


# 1960s
music60s <- get_playlist_audio_features("spotify", 
                                        playlist_uris = "37i9dQZF1DXaKIA8E7WcJj",
                                        authorization = my_token) %>%
  mutate(tag = "1960s")



# Music from 1970s - special focus
music70s.1 <- get_playlist_audio_features("spotify", 
                                          playlist_uris = "37i9dQZF1DWTJ7xPn4vNaz",
                                          authorization = my_token) %>%
  mutate(tag = "1970s")

music70s.2 <- get_playlist_audio_features("spotify", 
                                          playlist_uris = "37i9dQZF1EQpVaHRDcozEz",
                                          authorization = my_token) %>%
  mutate(tag = "1970s")
music70s.3 <- get_playlist_audio_features("spotify", 
                                          playlist_uris = "37i9dQZF1DWWiDhnQ2IIru",
                                          authorization = my_token) %>%
  mutate(tag = "1970s")

# Get only unique music
music70s.2 <- music70s.2[!music70s.2$track.id %in% music70s.1$track.id,]

# Join
music70s <- bind_rows(music70s.1, music70s.2)

# Additional 70s music 


# 1980s
music80s <- get_playlist_audio_features("spotify", 
                                        playlist_uris = "37i9dQZF1DX4UtSsGT1Sbe",
                                        authorization = my_token) %>%
  mutate(tag = "1980s")

# 1990s
music90s <- get_playlist_audio_features("spotify", 
                                        playlist_uris = "37i9dQZF1DXbTxeAdrVG2l",
                                        authorization = my_token) %>%
  mutate(tag = "1990s")

# 2000s
music00s <- get_playlist_audio_features("spotify", 
                                        playlist_uris = "37i9dQZF1DX4o1oenSJRJd",
                                        authorization = my_token) %>%
  mutate(tag = "2000s")
# 2010s
music10s <- get_playlist_audio_features("spotify", 
                                        playlist_uris = "37i9dQZF1DX5Ejj0EkURtP",
                                        authorization = my_token) %>%
  mutate(tag = "2010s")

# 2020s - special focus
music20s.1 <- get_playlist_audio_features("spotify", 
                                          playlist_uris = "37i9dQZF1DX7Jl5KP2eZaS",
                                          authorization = my_token) %>%
  mutate(tag = "2020s")

music20s.2 <- get_playlist_audio_features("spotify", 
                                          playlist_uris = "37i9dQZF1DX18jTM2l2fJY",
                                          authorization = my_token) %>%
  mutate(tag = "2020s")

music20s.3 <- get_playlist_audio_features("spotify", 
                                          playlist_uris = "37i9dQZF1DX0kbJZpiYdZl",
                                          authorization = my_token) %>%
  mutate(tag = "2020s")

# This one is not from spotify but very popular and from filtr
music20s.4 <- get_playlist_audio_features("spotify", 
                                          playlist_uris = "49oW3sCI91kB2YGw7hsbBv",
                                          authorization = my_token) %>%
  mutate(tag = "2020s")
# Bind all rows
decades <- bind_rows(music50s, music60s, music70s.1,
                     music70s.2, music70s.3,  music80s, 
                     music90s, music00s, music10s,
                     music20s.1, music20s.2,
                     music20s.3, music20s.4)

# Filter Variables
decades.filtered <- decades %>%
  select(track.id, track.name, track.popularity, track.album.album_type, track.duration_ms, danceability, energy,
         loudness, speechiness, acousticness, instrumentalness, liveness, valence, tempo,
         track.album.release_date,
         tag)

# Check for duplicates
decades.filtered <- decades.filtered[!duplicated(decades.filtered),]

table(decades.filtered$tag)

write_csv(decades.filtered, "spotify_decades.csv")
