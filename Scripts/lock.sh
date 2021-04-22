#!/bin/sh

B='#00000000'  # blank
C='#ffffff22'  # clear ish
D='#00bbb8'  # verifying
T='#ffffff'  # text
W='#ff1c49'  # wrong
V='#00bb61'  # verifying

/usr/bin/i3lock \
--insidevercolor=$C   \
--ringvercolor=$V     \
\
--insidewrongcolor=$C \
--ringwrongcolor=$W   \
\
--insidecolor=$B      \
--ringcolor=$D        \
--linecolor=$B        \
--separatorcolor=$D   \
\
--verifcolor=$T        \
--wrongcolor=$T        \
--timecolor=$T        \
--datecolor=$T        \
--layoutcolor=$T      \
--keyhlcolor=$W       \
--bshlcolor=$W        \
\
--screen 1            \
--blur 5              \
--clock               \
--indicator           \
--timestr="%H:%M:%S"  \
--datestr="%A, %m %Y" \
--keylayout 1         \
--veriftext="Verifying"   \
--wrongtext="Incorrect"   \
--layout-font=Quark   \
--verif-font=Quark   \
--wrong-font=Quark   \
--greeter-font=Quark   \
--date-font=Quark   \
--time-font=Quark   \
-n; xmodmap $HOME/.Xmodmap &   \

# --veriftext="Drinking verification can..."
# --wrongtext="Nope!"
# --textsize=20
# --modsize=10
# --timefont=comic-sans
# --datefont=monofur
# etc
