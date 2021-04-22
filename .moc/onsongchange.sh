#!/usr/sh

####################################################################
#                    MOC CONFIG FILE
####################################################################
#     %a artist
#     %r album
#     %f filename
#     %t title
#     %n track
#     %d file duration in XX:YY form
#     %D file duration, number of seconds
#
#     OnSongChange="/home/YOU/.moc/onsongchange.sh %a %t %r %f"
#     
#     Note:Use the %f in the end for especial cases.
####################################################################

ARTIST="$1"

TITLE="$2"

ALBUM="$3"

FILE="$4"

FOLDER="${FILE%/*}"

ICON="$FOLDER/tmpicon.png"

# Try to extract cover image from metadata
ffmpeg -i $FILE $ICON

# Try .jpg first
if [ ! -f "$ICON" ]; then
    # Set default image
    ICON="audio-x-generic"
fi

# Check if empty

if [ -z "$ARTIST" ] || [ -z "$TITLE" ] || [ -z "$ALBUM" ]; then
    SONG_NAME=${FILE##*/}
    notify-send "Mocp" "Title: $SONG_NAME" --icon=$ICON
else
    notify-send "Mocp" "Title: $TITLE\nArtist: $ARTIST\nAlbum: $ALBUM" --icon=$ICON
fi

exit $?
