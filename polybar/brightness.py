#!/usr/bin/env python

import os
from codecs import open

def main():
    try:
        #return '{}, {}°F'.format(desc, temp)
        brightness = os.system('light -G')
        return '{}%'.format(brightness)
    except:
        return ''


if __name__ == "__main__":
	print(main())
