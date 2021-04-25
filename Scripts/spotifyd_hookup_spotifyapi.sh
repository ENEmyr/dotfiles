#!/bin/sh

user_id=ee584c5154e8494793434eb66750adc0 # generated on https://developer.spotify.com/dashboard/applications
secret_id=f72426d1499244c5b6dadc572fa7c9bc

myToken=$(curl -s -X 'POST' -u $user_id:$secret_id -d grant_type=client_credentials https://accounts.spotify.com/api/token | jq '.access_token' | cut -d\" -f2)
RESULT=$?

[[ ! -d $HOME/.tmp ]] && mkdir $HOME/.tmp

if [ "$PLAYER_EVENT" = "start" ] || [ "$PLAYER_EVENT" = "change" ] || [ "$PLAYER_EVENT" = "stop" ]; then
	if [ $RESULT -eq 0 ]; then
		content=$(curl -s -X 'GET' https://api.spotify.com/v1/tracks/$TRACK_ID -H 'Accept: application/json' -H 'Content-Type: application/json' -H "Authorization:\"Bearer $myToken\"")
		song_name=$(jq -r '.name' <<< "${content}i")
		artist_name=$(jq -r '.artists[].name' <<< "${content}")
		album_name=$(jq -r '.album.name' <<< "${content}")
		album_release_date=$(jq -r '.album.release_date' <<< "${content}")
		cover_img_url=$(jq -r '.album.images[2].url' <<< "${content}")
		curl $cover_img_url -o $HOME/.tmp/spotifyd-cover-img-tmp.png
		if [ "$PLAYER_EVENT" = "start" ]; then
			notify-send "Spotifyd:Start" "Song Name: $song_name\nArtists: $artist_name\nAlbum: $album_name\nAlbum Release: $album_release_date" --icon=$HOME/.tmp/spotifyd-cover-img-tmp.png --urgency=low --expire-time=3000 --app-name=spotifyd 
		elif [ "$PLAYER_EVENT" = "change" ]; then
			notify-send "Spotifyd:Change" "Song Name: $song_name\nArtists: $artist_name\nAlbum: $album_name\nAlbum Release: $album_release_date" --icon=$HOME/.tmp/spotifyd-cover-img-tmp.png --urgency=low --expire-time=3000 --app-name=spotifyd 
		elif [ "$PLAYER_EVENT" = "stop" ]; then
			notify-send "Spotifyd:Stop" "Song Name: $song_name\nArtists: $artist_name\nAlbum: $album_name\nAlbum Release: $album_release_date" --icon=$HOME/.tmp/spotifyd-cover-img-tmp.png --urgency=low --expire-time=3000 --app-name=spotifyd 
		fi
		rm $HOME/.tmp/spotifyd-cover-img-tmp.png
	else
		echo "Cannot get token."
	fi
else
	echo "Unknown event."
fi
