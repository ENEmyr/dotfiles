import sys
from os.path import basename
from subprocess import run, PIPE
from optparse import OptionParser, make_option

options = [
    make_option('-t', '--truncate_len', type=int, dest='trunclen', help='trancate length for return string', default=35)
]
parser = OptionParser(option_list=options)

'''
    Command: "mocp --info"

    Available status
    - State : For check play pause status can be PLAY, PAUSE, STOP
        * Durring STOP state the command will print nothing except State*
    - File : For locate absolute path of playing file
    - Title : Full information of current song, song title, artist and album meatadata has been included
    - Artist : A metadata about artist name
    - SongTitle : A metadata about song title 
    - Album : A metadata about album name
    - TotalTime : A metadata about file duration in format MM:SS
    - TimeLeft : A metadata about duration left in format MM:SS
    - TotalSec : A metadata about file duration in format SS
    - CurrentTime : A metadata about current time  in format MM:SS
    - CurrentSec : A metadata about current time in format SS
    - Bitrate : A metadata about file bitrate
    - AvgBitrate : A metadata about average file bitrate
    - Rate : A metadata about Rate
'''

def fix_string(string):
    # corrects encoding for the python version used
    if sys.version_info.major == 3:
        return string
    else:
        return string.encode('utf-8')

def truncate(name, trunclen):
    if len(name) > trunclen:
        name = name[:trunclen]
        name += '...'
        if ('(' in name) and (')' not in name):
            name += ')'
    return name

try:
    (options, args) = parser.parse_args()
    output_format = '{play_pause} {song_title} - {artist}'
    play_pause = fix_string(u'\u25B6,\u23F8') # first character is play, second is paused
    status_str = run(['mocp', '--info'], stdout=PIPE)
    status = {}
    for line in status_str.stdout.decode('utf-8').split('\n')[:-1]:
        splited_line = line.split(':')
        status[splited_line[0]] = splited_line[1].strip().replace('\n', '')

    if status['State'] == 'PLAY':
        play_pause = play_pause.split(',')[0]
    elif status['State'] == 'PAUSE':
        play_pause = play_pause.split(',')[1]

    if status['State'] != 'STOP':
        if not status['SongTitle'] or not status['Artist'] or not status['Album']:
            output_format = '{play_pause} {title}'
            print(truncate(output_format.format(
                play_pause=play_pause,
                title=basename(status['File'])
            ), options.trunclen+2))
        else:
            print(truncate(output_format.format(
                play_pause=play_pause,
                song_title=status['SongTitle'],
                artist=status['Artist']
            ), options.trunclen+4))
    else:
        print('')
except Exception as e:
    print('')
